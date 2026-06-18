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
    anonymous_loader_lib = File.join(Gem.loaded_specs.fetch("anonymous_loader").full_gem_path, "lib")
    auth_sanitizer_lib = File.join(Gem.loaded_specs.fetch("auth-sanitizer").full_gem_path, "lib")
    version_gem_lib = File.join(Gem.loaded_specs.fetch("version_gem").full_gem_path, "lib")
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
    passthrough_env_keys = %w[
      GEM_HOME
      GEM_PATH
      HOME
      PATH
      PATHEXT
      SystemRoot
      TEMP
      TMP
      TMPDIR
      WINDIR
    ]
    ruby_env = passthrough_env_keys.each_with_object({}) do |key, env|
      env[key] = ENV[key] if ENV.key?(key)
    end

    stdout, stderr, status = Open3.capture3(
      ruby_env,
      RbConfig.ruby,
      "--disable=gems",
      "-I",
      oauth2_lib,
      "-I",
      anonymous_loader_lib,
      "-I",
      auth_sanitizer_lib,
      "-I",
      version_gem_lib,
      "-e",
      script,
      unsetenv_others: true
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
