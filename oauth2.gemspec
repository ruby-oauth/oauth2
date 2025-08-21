# encoding: utf-8
# frozen_string_literal: true

gem_version =
  if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new("3.1")
    # Loading Version into an anonymous module allows version.rb to get code coverage from SimpleCov!
    # See: https://github.com/simplecov-ruby/simplecov/issues/557#issuecomment-2630782358
    Module.new.tap { |mod| Kernel.load("lib/oauth2/version.rb", mod) }::OAuth2::Version::VERSION
  else
    require_relative "lib/oauth2/version"
    OAuth2::Version::VERSION
  end

Gem::Specification.new do |spec|
  spec.name = "oauth2"
  spec.version = gem_version
  spec.authors = ["Peter Boling", "Erik Michaels-Ober", "Michael Bleigh"]
  spec.email = ["floss@galtzo.com"]

  # Linux distros often package gems and securely certify them independent
  #   of the official RubyGem certification process. Allowed via ENV["SKIP_GEM_SIGNING"]
  # Ref: https://gitlab.com/ruby-oauth/version_gem/-/issues/3
  # Hence, only enable signing if `SKIP_GEM_SIGNING` is not set in ENV.
  # See CONTRIBUTING.md
  unless ENV.include?("SKIP_GEM_SIGNING")
    user_cert = "certs/#{ENV.fetch("GEM_CERT_USER", ENV["USER"])}.pem"
    cert_file_path = File.join(__dir__, user_cert)
    cert_chain = cert_file_path.split(",")
    cert_chain.select! { |fp| File.exist?(fp) }
    if cert_file_path && cert_chain.any?
      spec.cert_chain = cert_chain
      if $PROGRAM_NAME.end_with?("gem") && ARGV[0] == "build"
        spec.signing_key = File.join(Gem.user_home, ".ssh", "gem-private_key.pem")
      end
    end
  end

  gl_homepage = "https://gitlab.com/ruby-oauth/#{spec.name}"
  gh_mirror = "https://github.com/ruby-oauth/#{spec.name}"

  spec.summary = "🔐 OAuth 2.0 & OIDC"
  spec.description = "🔐 Ruby wrapper for the OAuth 2.0 protocol, including OIDC"
  spec.homepage = gh_mirror
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.2.0"

  spec.post_install_message = %{
---+++ oauth2 v#{gem_version} +++---

There are BREAKING CHANGES when upgrading from < v2
Most will not encounter them, and updating your code should be easy!
Please see:
• #{gl_homepage}/-/blob/main/SECURITY.md
• #{gl_homepage}/-/blob/v#{spec.version}/CHANGELOG.md#200-2022-06-21-tag
• Summary of most important breaking changes: #{gl_homepage}#what-is-new-for-v20

News:
1. New documentation website: https://oauth2.galtzo.com
2. Discord for discussion and support: https://discord.gg/3qme4XHNKN
3. Non-commercial support for the 2.x series will end by April, 2026. Please make a plan to upgrade to the next version prior to that date.
Support will be dropped for Ruby 2.2, 2.3, 2.4, 2.5, 2.6, 2.7, 3.0, 3.1 and any other Ruby versions which will also have reached EOL by then.
4. Gem releases are now cryptographically signed with a 20-year cert, with checksums by stone_checksums.
5. Please consider supporting this project, and my other open source work, with one of the following methods:
• https://liberapay.com/pboling
• https://ko-fi.com/pboling
• https://www.buymeacoffee.com/pboling
• https://github.com/sponsors/pboling

If you are a corporation, please consider supporting this project, and open source work generally, with a TideLift subscription.
• https://tidelift.com/funding/github/rubygems/oauth
• Or hire me. I am looking for a job!

Please report issues, and star the project!

Thanks, |7eter l-|. l3oling
}

  spec.metadata["homepage_uri"] = "https://#{spec.name}.galtzo.com/"
  spec.metadata["source_code_uri"] = "#{gh_mirror}/releases/tag//v#{spec.version}"
  spec.metadata["changelog_uri"] = "#{gl_homepage}/-/blob/v#{spec.version}/CHANGELOG.md"
  spec.metadata["bug_tracker_uri"] = "#{gl_homepage}/-/issues"
  spec.metadata["documentation_uri"] = "https://www.rubydoc.info/gems/#{spec.name}/#{spec.version}"
  spec.metadata["mailing_list_uri"] = "https://groups.google.com/g/oauth-ruby"
  spec.metadata["funding_uri"] = "https://github.com/sponsors/pboling"
  spec.metadata["wiki_uri"] = "#{gl_homepage}/-/wiki"
  spec.metadata["news_uri"] = "https://www.railsbling.com/tags/#{spec.name}"
  spec.metadata["discord_uri"] = "https://discord.gg/3qme4XHNKN"
  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir[
    # Splats (alphabetical)
    "lib/**/*",
  ]
  # Automatically included with gem package, no need to list again in files.
  spec.extra_rdoc_files = Dir[
    # Files (alphabetical)
    "CHANGELOG.md",
    "CODE_OF_CONDUCT.md",
    "CONTRIBUTING.md",
    "LICENSE.txt",
    "README.md",
    "SECURITY.md",
  ]
  spec.rdoc_options += [
    "--title",
    "#{spec.name} - #{spec.summary}",
    "--main",
    "CHANGELOG.md",
    "CODE_OF_CONDUCT.md",
    "CONTRIBUTING.md",
    "LICENSE.txt",
    "README.md",
    "SECURITY.md",
    "--line-numbers",
    "--inline-source",
    "--quiet",
  ]
  spec.require_paths = ["lib"]
  spec.bindir = "exe"
  spec.executables = []

  spec.add_dependency("faraday", [">= 0.17.3", "< 4.0"])  # Ruby >= 1.9
  spec.add_dependency("jwt", [">= 1.0", "< 4.0"])         # Ruby >= 0
  spec.add_dependency("logger", "~> 1.2")                 # Ruby >= 0
  spec.add_dependency("multi_xml", "~> 0.5")              # Ruby >= 0
  spec.add_dependency("rack", [">= 1.2", "< 4"])          # Ruby >= 0
  spec.add_dependency("snaky_hash", "~> 2.0", ">= 2.0.3") # Ruby >= 2.2
  spec.add_dependency("version_gem", ">= 1.1.8", "< 3")   # Ruby >= 2.2

  # NOTE: It is preferable to list development dependencies in the gemspec due to increased
  #       visibility and discoverability on RubyGems.org.
  #       However, development dependencies in gemspec will install on
  #       all versions of Ruby that will run in CI.
  #       This gem, and its runtime dependencies, will install on Ruby down to 2.2.
  #       This gem, and its development dependencies, will install on Ruby down to 2.3.
  #       This is because in CI easy installation of Ruby, via setup-ruby, is for >= 2.3.
  #       Thus, dev dependencies in gemspec must have
  #
  #       required_ruby_version ">= 2.3" (or lower)
  #
  #       Development dependencies that require strictly newer Ruby versions should be in a "gemfile",
  #       and preferably a modular one (see gemfiles/modular/*.gemfile).

  spec.add_development_dependency("addressable", "~> 2.8", ">= 2.8.7")  # ruby >= 2.2
  spec.add_development_dependency("appraisal2", "~> 3.0")               # ruby >= 1.8.7
  spec.add_development_dependency("backports", "~> 3.25", ">= 3.25.1")  # ruby >= 0
  spec.add_development_dependency("nkf", "~> 0.2")                      # ruby >= 2.3
  spec.add_development_dependency("rake", "~> 13.0")                    # ruby >= 2.2
  spec.add_development_dependency("rexml", "~> 3.2", ">= 3.2.5")        # ruby >= 0
  spec.add_development_dependency("rspec", "~> 3.13")                   # ruby >= 0
  spec.add_development_dependency("rspec-block_is_expected", "~> 1.0", ">= 1.0.6")  # ruby >= 1.8.7
  spec.add_development_dependency("rspec-pending_for", "~> 0.1", ">= 0.1.17")       # ruby >= 1.8.7
  spec.add_development_dependency("rspec-stubbed_env", "~> 1.0", ">= 1.0.2")        # ruby >= 1.8.7
  spec.add_development_dependency("silent_stream", "~> 1.0", ">= 1.0.11")           # ruby >= 2.3
  spec.add_development_dependency("stone_checksums", "~> 1.0")                      # ruby >= 2.2
end
