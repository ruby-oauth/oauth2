# frozen_string_literal: true

module OAuth2
  AUTH_SANITIZER = begin
    auth_sanitizer_spec = Gem.loaded_specs["auth-sanitizer"] ||
      Gem::Specification.find_by_name("auth-sanitizer")
    auth_sanitizer_loader_path = File.join(
      auth_sanitizer_spec.full_gem_path,
      "lib/auth_sanitizer/loader.rb",
    )

    auth_sanitizer_loader_namespace = Module.new
    auth_sanitizer_loader_namespace.module_eval(
      File.read(auth_sanitizer_loader_path),
      auth_sanitizer_loader_path,
      1,
    )

    auth_sanitizer_loader_namespace
      .const_get(:AuthSanitizer)
      .const_get(:Loader)
      .load_isolated
  end
end
