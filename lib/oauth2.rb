# frozen_string_literal: true

# includes modules from stdlib
require "cgi/escape"
require "time"

# third party gems
require "snaky_hash"
require "version_gem"

# includes gem files
require_relative "oauth2/version"
require_relative "oauth2/auth_sanitizer"
require_relative "oauth2/filtered_attributes"
require_relative "oauth2/error"
require_relative "oauth2/authenticator"
require_relative "oauth2/client"
require_relative "oauth2/strategy/base"
require_relative "oauth2/strategy/auth_code"
require_relative "oauth2/strategy/implicit"
require_relative "oauth2/strategy/password"
require_relative "oauth2/strategy/client_credentials"
require_relative "oauth2/strategy/assertion"
require_relative "oauth2/access_token"
require_relative "oauth2/response"

# The namespace of this library
#
# This module is the entry point and top-level namespace for the oauth2 gem.
# It exposes configuration, constants, and requires the primary public classes.
module OAuth2
  # When true, enables verbose HTTP logging via Faraday's logger middleware.
  # Controlled by the OAUTH_DEBUG environment variable. Any case-insensitive
  # value equal to "true" will enable debugging.
  #
  # @return [Boolean]
  OAUTH_DEBUG = ENV.fetch("OAUTH_DEBUG", "false").casecmp("true").zero?

  # Default configuration values for the oauth2 library.
  #
  # @example Toggle warnings
  #   OAuth2.configure do |config|
  #     config[:silence_extra_tokens_warning] = false
  #     config[:silence_no_tokens_warning] = false
  #   end
  #
  # @example Customize filtered output markers and debug-log value filtering by key name
  #   OAuth2.configure do |config|
  #     config[:filtered_label] = "[REDACTED]"
  #     config[:filtered_debug_keys] += ["client_assertion"]
  #   end
  #
  # Existing objects and logger wrappers snapshot filtering configuration during
  # initialization. Changing these config values later affects only newly
  # initialized objects and debug loggers.
  #
  # @return [SnakyHash::SymbolKeyed] A mutable Hash-like config with symbol keys
  DEFAULT_CONFIG = SnakyHash::SymbolKeyed.new(
    silence_extra_tokens_warning: true,
    silence_no_tokens_warning: true,
    filtered_label: "[FILTERED]",
    filtered_debug_keys: %w[
      access_token
      refresh_token
      id_token
      client_secret
      assertion
      code_verifier
      token
    ]
  )

  # The current runtime configuration for the library.
  #
  # @return [SnakyHash::SymbolKeyed]
  CONFIG = DEFAULT_CONFIG.dup

  class << self
    def config
      CONFIG
    end

    # Configure global library behavior.
    #
    # Yields the mutable configuration object so callers can update settings.
    #
    # @yieldparam [SnakyHash::SymbolKeyed] config the configuration object
    # @return [void]
    def configure
      yield config
    end
  end
end

# Wire OAuth2::AUTH_SANITIZER's label provider to read from OAuth2.config so that
# FilteredAttributes-bearing objects and OAuth2::AUTH_SANITIZER::SanitizedLogger instances
# pick up OAuth2.config[:filtered_label] at their initialization time.
OAuth2::AUTH_SANITIZER.filtered_label_provider = -> { OAuth2.config[:filtered_label] }

# Extend OAuth2::Version with VersionGem helpers to provide semantic version helpers.
OAuth2::Version.class_eval do
  extend VersionGem::Basic
end
