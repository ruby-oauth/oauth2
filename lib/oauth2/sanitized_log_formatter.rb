# frozen_string_literal: true

require "faraday"

module OAuth2
  if defined?(Faraday::Logging::Formatter) # Faraday >= 1.0
    # Faraday logging formatter that redacts sensitive values from Hash and Array
    # request/response bodies BEFORE Faraday renders them (via `pretty_inspect`).
    #
    # Text-level sanitization ({OAuth2::AUTH_SANITIZER::SanitizedLogger}) remains as a
    # second layer for headers, query strings, and already-serialized bodies.
    #
    # Redaction rules:
    # - keys matching any filtered key (case-insensitive) are redacted, nested at any depth
    # - the authorization `code` is redacted only in an authorization_code grant context,
    #   detected from the request URL query or the body itself, so non-secret codes
    #   (e.g. error codes) are preserved
    # - cyclic structures are tolerated
    #
    # Requires Faraday >= 1.0 (Faraday::Logging::Formatter). On Faraday 0.17 this
    # class is not defined and the caller falls back to text-level sanitization only.
    #
    # @api private
    class SanitizedLogFormatter < Faraday::Logging::Formatter
      # Keys redacted only in an authorization_code grant context.
      CONTEXTUAL_KEYS = %w[code].freeze

      # Faraday instantiates formatters itself with (logger:, options:), so the
      # redaction configuration falls back to the current OAuth2.config values.
      #
      # @param filtered_keys [Array<String>, nil] key names to redact unconditionally
      # @param label [String, nil] replacement label
      # @param options [Hash] Faraday formatter options
      def initialize(filtered_keys: nil, label: nil, **options)
        super(**options)
        config = OAuth2.config
        @filtered_keys = (filtered_keys || config[:filtered_debug_keys]).map { |key| key.to_s.downcase }.freeze
        @label = (label || config[:filtered_label]).to_s
        @code_context = false
      end

      # Log the request, detecting authorization_code context from the URL and body.
      #
      # @param env [Faraday::Env] request environment
      def request(env)
        with_code_context(env) do
          if @code_context && env.respond_to?(:url) && env.url && env.url.query.to_s.include?("code=")
            # Log a sanitized COPY of the env; the real request must keep its URL.
            sanitized_env = env.dup
            sanitized_env.url = sanitize_url_code(env.url)
            super(sanitized_env)
          else
            super
          end
        end
      end

      # Log the response, detecting authorization_code context from the URL and body.
      #
      # @param env [Faraday::Env] response environment
      def response(env)
        with_code_context(env) { super }
      end

      # Redact structured bodies before rendering; leave everything else to the parent.
      #
      # @param body [Object] request or response body
      # @return [String] rendered body for logging
      def dump_body(body)
        case body
        when Hash, Array
          super(redact_structured(body, seen: {}, code_sensitive: @code_context))
        when String
          super(@code_context ? redact_code_in_string(body) : body)
        else
          super
        end
      end

      private

      # Redact the authorization `code` value in URL-encoded, JSON, and
      # Hash#inspect-shaped string bodies. Only called in authorization_code
      # grant context, so `code` always names the credential here.
      def redact_code_in_string(body)
        body.dup.scrub
          .gsub(/\bcode=[^&\s"']+/, "code=#{@label}")
          .gsub(/("code"\s*:\s*")[^"]*(")/i) { "#{$1}#{@label}#{$2}" }
          .gsub(/(("code"|code:)\s*=>?\s*")[^"]*(")/i) { "#{$1}#{@label}#{$3}" }
      end

      # Redact the `code` query parameter of a URL, returning a new URI.
      def sanitize_url_code(url)
        sanitized = url.dup
        pairs = sanitized.query.to_s.tr("+", " ").split("&").map do |pair|
          pair =~ /\Acode=/ ? "code=#{@label}" : pair
        end
        sanitized.query = pairs.join("&")
        sanitized
      end

      def with_code_context(env)
        previous = @code_context
        @code_context = previous || authorization_code_request?(env)
        yield
      ensure
        @code_context = previous
      end

      def authorization_code_request?(env)
        url = env.respond_to?(:url) ? env.url : nil
        if url
          query_pairs = url.query.to_s.tr("+", " ").split("&")
          return true if query_pairs.any? { |pair| pair == "grant_type=authorization_code" }
        end

        body = env.respond_to?(:body) ? env.body : nil
        case body
        when String
          scrubbed = body.dup.scrub
          scrubbed.match?(/grant_type=authorization_code/) ||
            scrubbed.match?(/grant(?:\\u005f|_)type\\?"?\s*:\s*\\?"authorization_code/)
        else
          authorization_code_context?(body) || authorization_code_pairs_context?(body)
        end
      end

      def redact_structured(node, seen:, code_sensitive:)
        return node if node.nil?

        case node
        when Hash
          object_id = node.object_id
          return seen[object_id] if seen.key?(object_id)

          copy = {}
          seen[object_id] = copy
          code_sensitive ||= authorization_code_context?(node)
          node.each do |key, value|
            copy[key] = if redact_key?(key, redact_code: code_sensitive)
              @label
            else
              redact_structured(value, seen: seen, code_sensitive: code_sensitive)
            end
          end
          copy
        when Array
          object_id = node.object_id
          return seen[object_id] if seen.key?(object_id)

          copy = []
          seen[object_id] = copy
          code_sensitive ||= authorization_code_pairs_context?(node)
          if pair_array?(node)
            node.each do |pair|
              copy << if redact_key?(pair[0], redact_code: code_sensitive)
                [pair[0], @label]
              else
                [pair[0], redact_structured(pair[1], seen: seen, code_sensitive: code_sensitive)]
              end
            end
          else
            node.each { |element| copy << redact_structured(element, seen: seen, code_sensitive: code_sensitive) }
          end
          copy
        else
          node
        end
      end

      def redact_key?(key, redact_code:)
        name = key.to_s.downcase
        return true if @filtered_keys.include?(name)

        redact_code && CONTEXTUAL_KEYS.include?(name)
      end

      def authorization_code_context?(node)
        node.is_a?(Hash) && node.any? { |key, value| key.to_s == "grant_type" && value.to_s == "authorization_code" }
      end

      def pair_array?(node)
        node.is_a?(Array) && !node.empty? && node.all? { |element| element.is_a?(Array) && element.length == 2 }
      end

      def authorization_code_pairs_context?(node)
        pair_array?(node) && node.any? { |pair| pair[0].to_s == "grant_type" && pair[1].to_s == "authorization_code" }
      end
    end
  end
end
