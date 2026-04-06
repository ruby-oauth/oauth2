# frozen_string_literal: true

module OAuth2
  # Logger wrapper that redacts sensitive values from debug output before
  # delegating to the underlying logger instance.
  #
  # This class is intentionally narrow in scope: it only sanitizes string
  # messages emitted through the debug logging path and leaves request/response
  # behavior unchanged.
  #
  # The underlying {ThingFilter} is initialized once when the logger wrapper is
  # created, so later config changes do not alter the behavior of existing
  # logger instances.
  class SanitizedLogger
    # Create a new sanitized logger wrapper.
    #
    # @param [#add, #debug, #info, #warn, #error, #fatal, #unknown] logger
    #   The underlying logger instance that will receive sanitized messages.
    #
    # The debug filtering key list and replacement label are snapshotted from
    # `OAuth2.config` during initialization.
    def initialize(logger)
      @logger = logger
      @thing_filter = ThingFilter.new(
        OAuth2.config[:filtered_debug_keys],
        label: OAuth2.config[:filtered_label],
      )
    end

    # Add a log entry after sanitizing any string payloads.
    #
    # @param [Integer, Symbol, String, nil] severity Logger severity
    # @param [Object, nil] message Optional log message
    # @param [Object, nil] progname Optional program name
    # @yieldreturn [Object] Deferred log message
    # @return [Object] The underlying logger result
    def add(severity, message = nil, progname = nil)
      if block_given?
        @logger.add(severity, sanitize(message), sanitize(progname)) { sanitize(yield) }
      else
        @logger.add(severity, sanitize(message), sanitize(progname))
      end
    end

    # Append a message to the underlying logger after sanitization.
    #
    # @param [String] message Message to append
    # @return [Object] The underlying logger result
    def <<(message)
      @logger << sanitize(message)
    end

    # Log a debug message after sanitization.
    #
    # @param [Object, nil] progname Optional program name
    # @yieldreturn [Object] Deferred log message
    # @return [Object] The underlying logger result
    def debug(progname = nil, &block)
      log(:debug, progname, &block)
    end

    # Log an info message after sanitization.
    #
    # @param [Object, nil] progname Optional program name
    # @yieldreturn [Object] Deferred log message
    # @return [Object] The underlying logger result
    def info(progname = nil, &block)
      log(:info, progname, &block)
    end

    # Log a warning message after sanitization.
    #
    # @param [Object, nil] progname Optional program name
    # @yieldreturn [Object] Deferred log message
    # @return [Object] The underlying logger result
    def warn(progname = nil, &block)
      log(:warn, progname, &block)
    end

    # Log an error message after sanitization.
    #
    # @param [Object, nil] progname Optional program name
    # @yieldreturn [Object] Deferred log message
    # @return [Object] The underlying logger result
    def error(progname = nil, &block)
      log(:error, progname, &block)
    end

    # Log a fatal message after sanitization.
    #
    # @param [Object, nil] progname Optional program name
    # @yieldreturn [Object] Deferred log message
    # @return [Object] The underlying logger result
    def fatal(progname = nil, &block)
      log(:fatal, progname, &block)
    end

    # Log an unknown-severity message after sanitization.
    #
    # @param [Object, nil] progname Optional program name
    # @yieldreturn [Object] Deferred log message
    # @return [Object] The underlying logger result
    def unknown(progname = nil, &block)
      log(:unknown, progname, &block)
    end

    # Close the underlying logger if supported.
    #
    # @return [void]
    def close
      @logger.close if @logger.respond_to?(:close)
    end

    # Access the formatter of the underlying logger if supported.
    #
    # @return [Object, nil]
    def formatter
      @logger.formatter if @logger.respond_to?(:formatter)
    end

    # Set the formatter of the underlying logger if supported.
    #
    # @param [Object] formatter Formatter object
    # @return [void]
    def formatter=(formatter)
      @logger.formatter = formatter if @logger.respond_to?(:formatter=)
    end

    # Access the logger level if supported.
    #
    # @return [Object, nil]
    def level
      @logger.level if @logger.respond_to?(:level)
    end

    # Set the logger level if supported.
    #
    # @param [Object] level Logger level
    # @return [void]
    def level=(level)
      @logger.level = level if @logger.respond_to?(:level=)
    end

    # Access the logger progname if supported.
    #
    # @return [Object, nil]
    def progname
      @logger.progname if @logger.respond_to?(:progname)
    end

    # Set the logger progname if supported.
    #
    # @param [Object] progname Logger progname
    # @return [void]
    def progname=(progname)
      @logger.progname = progname if @logger.respond_to?(:progname=)
    end

    # Report support for methods provided by the wrapped logger.
    #
    # @param [Symbol] method_name Method name to check
    # @param [Boolean] include_private Whether private methods are considered
    # @return [Boolean]
    def respond_to_missing?(method_name, include_private = false)
      @logger.respond_to?(method_name, include_private) || super
    end

    # Delegate unsupported methods to the wrapped logger.
    #
    # @param [Symbol] method_name Method to invoke
    # @param [Array<Object>] args Method arguments
    # @yield Deferred block forwarded to the wrapped logger
    # @return [Object] The delegated result
    def method_missing(method_name, *args, &block)
      return super unless @logger.respond_to?(method_name)

      @logger.public_send(method_name, *args, &block)
    end

  private

    # Dispatch a severity-specific log call after sanitization.
    #
    # @param [Symbol] level Logger method name
    # @param [Object, nil] progname Optional program name
    # @yieldreturn [Object] Deferred log message
    # @return [Object] The underlying logger result
    def log(level, progname = nil)
      if block_given?
        @logger.public_send(level, sanitize(progname)) { sanitize(yield) }
      else
        @logger.public_send(level, sanitize(progname))
      end
    end

    # Sanitize a logger message when it is a String.
    #
    # @param [Object] message Potential logger payload
    # @return [Object] Unchanged non-String payloads, sanitized String payloads
    def sanitize(message)
      return message unless message.is_a?(String)

      sanitized = message.dup
      sanitized = sanitize_authorization_header(sanitized)
      sanitized = sanitize_json_pairs(sanitized)
      sanitize_form_and_query_pairs(sanitized)
    end

    # The initialized thing filter used by this logger.
    #
    # This is a per-logger snapshot created during initialization.
    #
    # @return [ThingFilter]
    attr_reader :thing_filter

    # Redact Authorization header values.
    #
    # @param [String] message Logger message
    # @return [String] Sanitized logger message
    def sanitize_authorization_header(message)
      message.gsub(/(Authorization:\s*)(?:\"[^\"]*\"|[^\r\n]+)/i, "\\1\"#{thing_filter.label}\"")
    end

    # Redact JSON-style values for configured sensitive key names.
    #
    # @param [String] message Logger message
    # @return [String] Sanitized logger message
    def sanitize_json_pairs(message)
      message.gsub(/([\"'])(#{thing_filter.pattern_source})\1(\s*:\s*)([\"'])(.*?)\4/i) do
        %(#{$1}#{$2}#{$1}#{$3}#{$4}#{thing_filter.label}#{$4})
      end
    end

    # Redact form-encoded and query-string values for configured sensitive key names.
    #
    # @param [String] message Logger message
    # @return [String] Sanitized logger message
    def sanitize_form_and_query_pairs(message)
      message.gsub(/(\b(?:#{thing_filter.pattern_source})=)([^&\s\"]+)/i, "\\1#{thing_filter.label}")
    end
  end
end
