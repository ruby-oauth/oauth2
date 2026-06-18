# frozen_string_literal: true

require "anonymous_loader"

module OAuth2
  AUTH_SANITIZER = begin
    auth_sanitizer_requirement = Gem::Requirement.new("~> 0.2", ">= 0.2.2")
    auth_sanitizer_loader_namespace = AnonymousLoader.load_path(
      gem_name: "auth-sanitizer",
      require_path: "auth_sanitizer/loader.rb",
      version_requirement: auth_sanitizer_requirement,
      version_file: "auth/sanitizer/version.rb"
    )

    auth_sanitizer_loader_namespace.
      const_get(:AuthSanitizer).
      const_get(:Loader).
      load_isolated
  end
end
