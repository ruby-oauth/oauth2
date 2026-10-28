# frozen_string_literal: true

require "faraday"
require "cgi"

begin
  require "faraday/logging/formatter"
rescue LoadError
  # Faraday 0.x does not support a structured logging formatter.
end

module OAuth2
  if defined?(Faraday::Logging::Formatter)
    # Redacts structured request and response bodies before Faraday renders them.
    # Faraday 0.x has no formatter API; Client disables body logging there.
    class SanitizedLogFormatter < Faraday::Logging::Formatter
      SENSITIVE_KEYS = [
        "access_token", "refresh_token", "client_secret", "code", "code_verifier",
        "password", "assertion", "id_token", "token", "client_assertion",
        "device_code", "subject_token", "actor_token", "accesstoken",
        "refreshtoken", "idtoken", "clientsecret", "codeverifier",
        "clientassertion", "devicecode", "subjecttoken", "actortoken"
      ].freeze

      LABEL = "[FILTERED]"

      def initialize(options = {})
        super(:logger => options[:logger], :options => options[:options] || {})
      end

      def request(env)
        return super unless env.respond_to?(:url) && env.url && env.url.query

        safe_env = env.dup
        safe_url = env.url.dup
        safe_url.query = sanitize_query(safe_url.query)
        safe_env.url = safe_url
        super(safe_env)
      end

      def dump_body(body)
        case body
        when Hash, Array
          super(redact_structured(body, {}))
        when String
          super(sanitize_string(body))
        else
          super
        end
      end

    private

      def redact_structured(value, seen)
        return value unless value.is_a?(Hash) || value.is_a?(Array)

        object_id = value.object_id
        return LABEL if seen[object_id]

        seen[object_id] = true
        if value.is_a?(Hash)
          value.each_with_object({}) do |(key, child), copy|
            copy[key] = sensitive_key?(key) ? LABEL : redact_structured(child, seen)
          end
        elsif pair_array?(value)
          value.map do |pair|
            [pair[0], sensitive_key?(pair[0]) ? LABEL : redact_structured(pair[1], seen)]
          end
        else
          value.map { |child| redact_structured(child, seen) }
        end
      end

      def pair_array?(value)
        !value.empty? && value.all? { |element| element.is_a?(Array) && element.length == 2 }
      end

      def sensitive_key?(key)
        SENSITIVE_KEYS.include?(key.to_s.downcase)
      end

      def sanitize_query(query)
        query.split(/([&;])/).map do |part|
          if part == "&" || part == ";"
            part
          else
            key, value = part.split("=", 2)
            if sensitive_key?(CGI.unescape(key.to_s))
              value ? "#{key}=#{LABEL}" : key
            else
              sanitize_string(part)
            end
          end
        end.join
      end

      def sanitize_string(value)
        safe_value = value.dup
        safe_value.force_encoding(Encoding::BINARY) if safe_value.respond_to?(:force_encoding)
        SENSITIVE_KEYS.each do |key|
          pattern = /(["']?#{Regexp.escape(key)}["']?\s*(?:=>|:|=)\s*)(?:"(?:\\.|[^"\\])*"|'(?:\\.|[^'\\])*'|[^&,\s}\]]+)/i
          safe_value.gsub!(pattern) { "#{Regexp.last_match(1)}#{LABEL}" }
        end
        safe_value
      end
    end
  end
end
