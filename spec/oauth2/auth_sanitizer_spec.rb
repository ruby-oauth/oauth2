# frozen_string_literal: true

require "open3"
require "rbconfig"

RSpec.describe "OAuth2::AUTH_SANITIZER" do
  it "keeps auth-sanitizer constants isolated inside the OAuth2 namespace" do
    expect(Object.const_defined?(:Auth, false)).to be(false)
    expect(Object.const_defined?(:AuthSanitizer, false)).to be(false)
  end

  it "preserves the public OAuth2::FilteredAttributes alias" do
    expect(OAuth2::FilteredAttributes).to be(OAuth2::AUTH_SANITIZER::FilteredAttributes)
  end

  it "loads when auth-sanitizer is only available on the load path, not GEM_PATH" do
    oauth2_lib = File.expand_path("../../lib", __dir__)
    auth_sanitizer_lib = File.join(Gem.loaded_specs.fetch("auth-sanitizer").full_gem_path, "lib")
    script = <<~'RUBY'
      require "rubygems"

      Gem.loaded_specs.delete("auth-sanitizer")

      class << Gem::Specification
        alias_method :oauth2_original_find_by_name, :find_by_name

        def find_by_name(name, *requirements)
          raise Gem::MissingSpecError.new(name, requirements) if name == "auth-sanitizer"

          oauth2_original_find_by_name(name, *requirements)
        end
      end

      require "oauth2/auth_sanitizer"
      abort("OAuth2::AUTH_SANITIZER was not loaded") unless OAuth2.const_defined?(:AUTH_SANITIZER, false)
    RUBY
    ruby_env = if defined?(Bundler)
      Bundler.with_unbundled_env { ENV.to_h }
    else
      ENV.to_h
    end
    %w[
      BUNDLE_BIN_PATH
      BUNDLE_GEMFILE
      BUNDLE_PATH
      BUNDLE_WITH
      BUNDLE_WITHOUT
      BUNDLER_VERSION
      RUBYGEMS_GEMDEPS
      RUBYLIB
      RUBYOPT
    ].each { |key| ruby_env[key] = nil }

    stdout, stderr, status = Open3.capture3(
      ruby_env,
      RbConfig.ruby,
      "--disable=gems",
      "-I",
      oauth2_lib,
      "-I",
      auth_sanitizer_lib,
      "-e",
      script
    )

    expect(status).to be_success, <<~MSG
      expected oauth2/auth_sanitizer to load with auth-sanitizer only on $LOAD_PATH

      stdout:
      #{stdout}

      stderr:
      #{stderr}
    MSG
  end
end
