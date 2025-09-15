# coding: utf-8
# frozen_string_literal: true

gem_version =
  if RUBY_VERSION >= "3.1" # rubocop:disable Gemspec/RubyVersionGlobalsUsage
    # Loading Version into an anonymous module allows version.rb to get code coverage from SimpleCov!
    # See: https://github.com/simplecov-ruby/simplecov/issues/557#issuecomment-2630782358
    # See: https://github.com/panorama-ed/memo_wise/pull/397
    Module.new.tap { |mod| Kernel.load("#{__dir__}/lib/oauth2/version.rb", mod) }::OAuth2::Version::VERSION
  else
    require_relative "lib/oauth2/version"
    OAuth2::Version::VERSION
  end

Gem::Specification.new do |spec|
  spec.name = "oauth2"
  spec.version = gem_version
  spec.authors = ["Peter Boling", "Erik Michaels-Ober", "Michael Bleigh"]
  spec.email = ["floss@galtzo.com", "oauth-ruby@googlegroups.com"]

  spec.summary = "🔐 OAuth 2.0, 2.1 & OIDC Core Ruby implementation"
  spec.description = "🔐 A Ruby wrapper for the OAuth 2.0 Authorization Framework, including the OAuth 2.1 draft spec, and OpenID Connect (OIDC)"
  spec.homepage = "https://github.com/ruby-oauth/oauth2"
  spec.licenses = ["MIT"]
  spec.required_ruby_version = ">= 2.2.0"

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
  gh_mirror = spec.homepage

  spec.post_install_message = %{
---+++--- oauth2 v#{gem_version} ---+++---

(minor) ⚠️ BREAKING CHANGES ⚠️ when upgrading from < v2
• Summary of breaking changes: #{gl_homepage}#what-is-new-for-v20
• Changes in this patch: #{gl_homepage}/-/blob/v#{gem_version}/CHANGELOG.md#2015-2025-09-08

News:
1. New documentation website, including for OAuth 2.1 and OIDC: https://oauth2.galtzo.com
2. New official Discord for discussion and support: https://discord.gg/3qme4XHNKN
3. New org name "ruby-oauth" on Open Source Collective, GitHub, GitLab, Codeberg (update git remotes!)
4. Non-commercial support for the 2.x series will end by April, 2026. Please make a plan to upgrade to the next version prior to that date.
Support will be dropped for Ruby 2.2, 2.3, 2.4, 2.5, 2.6, 2.7, 3.0, 3.1 and any other Ruby versions which will also have reached EOL by then.
5. Gem releases are cryptographically signed with a 20-year cert; SHA-256 & SHA-512 checksums by stone_checksums.
6. Please consider supporting this project:
   • https://opencollective.com/ruby-oauth (new!)
   • https://liberapay.com/pboling
   • https://github.com/sponsors/pboling
   • https://www.paypal.com/paypalme/peterboling
   • https://ko-fi.com/pboling
   • https://www.buymeacoffee.com/pboling
   • https://tidelift.com/funding/github/rubygems/oauth
   • Hire me - I can build anything
   • Report issues, and star the project
Thanks, @pboling / @galtzo
}

  spec.metadata["homepage_uri"] = "https://#{spec.name.tr("_", "-")}.galtzo.com/"
  spec.metadata["source_code_uri"] = "#{gh_mirror}/tree/v#{spec.version}"
  spec.metadata["changelog_uri"] = "#{gh_mirror}/blob/v#{spec.version}/CHANGELOG.md"
  spec.metadata["bug_tracker_uri"] = "#{gh_mirror}/issues"
  spec.metadata["documentation_uri"] = "https://www.rubydoc.info/gems/#{spec.name}/#{spec.version}"
  spec.metadata["mailing_list_uri"] = "https://groups.google.com/g/oauth-ruby"
  spec.metadata["funding_uri"] = "https://github.com/sponsors/pboling"
  spec.metadata["wiki_uri"] = "#{gl_homepage}/-/wiki"
  spec.metadata["news_uri"] = "https://www.railsbling.com/tags/#{spec.name}"
  spec.metadata["discord_uri"] = "https://discord.gg/3qme4XHNKN"
  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files are part of the released package.
  spec.files = Dir[
    # Executables and tasks
    "exe/*",
    "lib/**/*.rb",
    "lib/**/*.rake",
    # Signatures
    "sig/**/*.rbs",
  ]

  # Automatically included with gem package, no need to list again in files.
  spec.extra_rdoc_files = Dir[
    # Files (alphabetical)
    "CHANGELOG.md",
    "CITATION.cff",
    "CODE_OF_CONDUCT.md",
    "CONTRIBUTING.md",
    "FUNDING.md",
    "LICENSE.txt",
    "OIDC.md",
    "README.md",
    "REEK",
    "RUBOCOP.md",
    "SECURITY.md",
  ]
  spec.rdoc_options += [
    "--title",
    "#{spec.name} - #{spec.summary}",
    "--main",
    "README.md",
    "--exclude",
    "^sig/",
    "--line-numbers",
    "--inline-source",
    "--quiet",
  ]
  spec.require_paths = ["lib"]
  spec.bindir = "exe"
  # files listed are relative paths from bindir above.
  spec.executables = []

  # Utilities
  spec.add_dependency("faraday", [">= 0.17.3", "< 4.0"])    # ruby >= 1.9
  spec.add_dependency("jwt", [">= 1.0", "< 4.0"])           # ruby >= 0
  spec.add_dependency("logger", "~> 1.2")                   # ruby >= 0
  spec.add_dependency("multi_xml", "~> 0.5")                # ruby >= 0
  spec.add_dependency("rack", [">= 1.2", "< 4"])            # ruby >= 0
  spec.add_dependency("snaky_hash", "~> 2.0", ">= 2.0.3")   # ruby >= 2.2
  spec.add_dependency("version_gem", "~> 1.1", ">= 1.1.9")  # ruby >= 2.2.0

  # NOTE: It is preferable to list development dependencies in the gemspec due to increased
  #       visibility and discoverability on RubyGems.org.
  #       However, development dependencies in gemspec will install on
  #       all versions of Ruby that will run in CI.
  #       This gem, and its gemspec runtime dependencies, will install on Ruby down to 2.2.x.
  #       This gem, and its gemspec development dependencies, will install on Ruby down to 2.3.x.
  #       This is because in CI easy installation of Ruby, via setup-ruby, is for >= 2.3.
  #       Thus, dev dependencies in gemspec must have
  #
  #       required_ruby_version ">= 2.3" (or lower)
  #
  #       Development dependencies that require strictly newer Ruby versions should be in a "gemfile",
  #       and preferably a modular one (see gemfiles/modular/*.gemfile).

  spec.add_development_dependency("addressable", "~> 2.8", ">= 2.8.7")  # ruby >= 2.2
  spec.add_development_dependency("nkf", "~> 0.2")                      # ruby >= 2.3
  spec.add_development_dependency("rexml", "~> 3.2", ">= 3.2.5")        # ruby >= 0

  # Dev, Test, & Release Tasks
  spec.add_development_dependency("kettle-dev", "~> 1.1", ">= 1.1.20")              # ruby >= 2.3.0

  # Security
  spec.add_development_dependency("bundler-audit", "~> 0.9.2")                      # ruby >= 2.0.0

  # Tasks
  spec.add_development_dependency("rake", "~> 13.0")                                # ruby >= 2.2.0

  # Debugging
  spec.add_development_dependency("require_bench", "~> 1.0", ">= 1.0.4")            # ruby >= 2.2.0

  # Testing
  spec.add_development_dependency("appraisal2", "~> 3.0")                           # ruby >= 1.8.7, for testing against multiple versions of dependencies
  spec.add_development_dependency("kettle-test", "~> 1.0")                          # ruby >= 2.3
  spec.add_development_dependency("rspec-pending_for", "~> 0.0", ">= 0.0.17")       # ruby >= 2.3, used to skip specs on incompatible Rubies

  # Releasing
  spec.add_development_dependency("ruby-progressbar", "~> 1.13")                    # ruby >= 0
  spec.add_development_dependency("stone_checksums", "~> 1.0", ">= 1.0.2")          # ruby >= 2.2.0

  # Git integration (optional)
  # The 'git' gem is optional; oauth2 falls back to shelling out to `git` if it is not present.
  # The current release of the git gem depends on activesupport, which makes it too heavy to depend on directly
  # spec.add_dependency("git", ">= 1.19.1")                               # ruby >= 2.3

  # Development tasks
  # The cake is a lie. erb v2.2, the oldest release on RubyGems.org, was never compatible with Ruby 2.3.
  # This means we have no choice but to use the erb that shipped with Ruby 2.3
  # /opt/hostedtoolcache/Ruby/2.3.8/x64/lib/ruby/gems/2.3.0/gems/erb-2.2.2/lib/erb.rb:670:in `prepare_trim_mode': undefined method `match?' for "-":String (NoMethodError)
  # spec.add_development_dependency("erb", ">= 2.2")                                  # ruby >= 2.3.0, not SemVer, old rubies get dropped in a patch.
  spec.add_development_dependency("gitmoji-regex", "~> 1.0", ">= 1.0.3")            # ruby >= 2.3.0

  # HTTP recording for deterministic specs
  # Ruby 2.3 / 2.4 can fail with:
  # | An error occurred while loading spec_helper.
  # | Failure/Error: require "vcr"
  # |
  # | NoMethodError:
  # |   undefined method `delete_prefix' for "CONTENT_LENGTH":String
  # | # ./spec/config/vcr.rb:3:in `require'
  # | # ./spec/config/vcr.rb:3:in `<top (required)>'
  # | # ./spec/spec_helper.rb:8:in `require_relative'
  # | # ./spec/spec_helper.rb:8:in `<top (required)>'
  # So that's why we need backports.
  spec.add_development_dependency("backports", "~> 3.25", ">= 3.25.1")  # ruby >= 0
  # In Ruby 3.5 (HEAD) the CGI library has been pared down, so we also need to depend on gem "cgi" for ruby@head
  # This is done in the "head" appraisal.
  # See: https://github.com/vcr/vcr/issues/1057
  spec.add_development_dependency("vcr", ">= 4")                        # 6.0 claims to support ruby >= 2.3, but fails on ruby 2.4
  spec.add_development_dependency("webmock", ">= 3")                    # Last version to support ruby >= 2.3
end
