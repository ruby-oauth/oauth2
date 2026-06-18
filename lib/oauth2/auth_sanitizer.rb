# frozen_string_literal: true

module OAuth2
  AUTH_SANITIZER = begin
    auth_sanitizer_requirement = Gem::Requirement.new("~> 0.2", ">= 0.2.1")
    auth_sanitizer_spec = Gem.loaded_specs["auth-sanitizer"]
    unless auth_sanitizer_spec && auth_sanitizer_requirement.satisfied_by?(auth_sanitizer_spec.version)
      # :nocov:
      begin
        auth_sanitizer_spec = Gem::Specification.find_by_name("auth-sanitizer", auth_sanitizer_requirement)
      rescue Gem::MissingSpecError
        auth_sanitizer_spec = nil
      end
      # :nocov:
    end

    auth_sanitizer_loader_path = if auth_sanitizer_spec
      File.join(auth_sanitizer_spec.full_gem_path, "lib/auth_sanitizer/loader.rb")
    end
    unless auth_sanitizer_loader_path && File.file?(auth_sanitizer_loader_path)
      auth_sanitizer_loader_path = Gem.find_files("auth_sanitizer/loader.rb").find do |path|
        version_path = File.expand_path("../auth/sanitizer/version.rb", File.dirname(path))
        next false unless File.file?(version_path)

        version_source = File.read(version_path)
        # Gem.find_files resolves loaders from $LOAD_PATH without exposing gemspec
        # metadata, so validate the adjacent version file before evaluating the
        # loader. This is intentionally limited to auth-sanitizer's VERSION file.
        version_match = version_source.match(/VERSION\s*=\s*(["'])([^"']+)\1/)
        version_match && auth_sanitizer_requirement.satisfied_by?(Gem::Version.new(version_match[2]))
      end
    end

    unless auth_sanitizer_loader_path && File.file?(auth_sanitizer_loader_path)
      # :nocov:
      raise LoadError, "oauth2 requires auth-sanitizer #{auth_sanitizer_requirement}; " \
        "loader not found in installed gems or on $LOAD_PATH"
      # :nocov:
    end

    auth_sanitizer_loader_namespace = Module.new
    auth_sanitizer_loader_namespace.module_eval(
      File.read(auth_sanitizer_loader_path),
      auth_sanitizer_loader_path,
      1
    )

    auth_sanitizer_loader_namespace.
      const_get(:AuthSanitizer).
      const_get(:Loader).
      load_isolated
  end
end
