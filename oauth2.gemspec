# frozen_string_literal: true

# kettle-jem:freeze
# To retain chunks of comments & code during kettle-jem templating:
# Wrap custom sections with freeze markers (e.g., as above and below this comment chunk).
# kettle-jem will then preserve content between those markers across template runs.
# kettle-jem:unfreeze

gem_version =
  if Gem.ruby_version >= Gem::Version.new("3.1")
    # Loading Version into an anonymous module allows version.rb to get code coverage from SimpleCov!
    # See: https://github.com/simplecov-ruby/simplecov/issues/557#issuecomment-2630782358
    # See: https://github.com/panorama-ed/memo_wise/pull/397
    Module.new.tap { |mod| Kernel.load("#{__dir__}/lib/oauth2/version.rb", mod) }::OAuth2::Version::VERSION
  else
    # NOTE: Use __FILE__ or __dir__ until removal of Ruby 1.x support
    # __dir__ introduced in Ruby 1.9.1
    lib = File.expand_path("lib", File.dirname(__FILE__))
    $LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
    require "oauth2/version"
    OAuth2::Version::VERSION
  end

Gem::Specification.new do |spec|
  spec.name = "oauth2"
  spec.version = gem_version
  spec.authors = ["Peter Boling", "Erik Michaels-Ober", "Michael Bleigh"]
  spec.email = ["peter.boling@gmail.com"]

  spec.summary = "🔐 A Ruby wrapper for the OAuth 2.0 protocol."
  spec.description = "🔐 A Ruby wrapper for the OAuth 2.0 protocol built with a similar style to the original OAuth spec."
  spec.homepage = "https://github.com/ruby-oauth/oauth2"
  spec.licenses = ["MIT"]
  spec.required_ruby_version = ">= 1.9.0" # rubocop:disable Gemspec/RequiredRubyVersion

  # Linux distros often package gems and securely certify them independent
  #   of the official RubyGem certification process. Allowed via ENV["SKIP_GEM_SIGNING"]
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

  spec.metadata["homepage_uri"] = "https://oauth2.galtzo.com"
  spec.metadata["source_code_uri"] = "#{spec.homepage}/tree/v#{spec.version}"
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/v#{spec.version}/CHANGELOG.md"
  spec.metadata["bug_tracker_uri"] = "#{spec.homepage}/issues"
  spec.metadata["documentation_uri"] = "https://www.rubydoc.info/gems/#{spec.name}/#{spec.version}"
  spec.metadata["funding_uri"] = "https://github.com/sponsors/pboling"
  spec.metadata["wiki_uri"] = "#{spec.homepage}/wiki"
  spec.metadata["news_uri"] = "https://www.railsbling.com/tags/#{spec.name}"
  spec.metadata["discord_uri"] = "https://discord.gg/3qme4XHNKN"
  spec.metadata["mailing_list_uri"] = "https://www.rubyforum.org/tag/oauth2"
  spec.metadata["rubygems_mfa_required"] = "true"

  gemspec_root = __dir__
  relative_package_path = lambda do |path|
    prefix = "#{gemspec_root}/"
    (path[0, prefix.length] == prefix) ? path[prefix.length..-1] : path
  end
  enumerate_package_glob = lambda do |glob|
    files = []
    Dir.glob(glob, File::FNM_DOTMATCH).each do |path|
      next unless File.file?(path) && ![".", ".."].include?(File.basename(path))

      files << relative_package_path.call(path)
    end
    files
  end
  enumerate_package_files = lambda do |root|
    enumerate_package_glob.call(File.join(gemspec_root, root, "**", "*"))
  end
  package_metadata_files = [
    "CHANGELOG.md",
    "LICENSE.md",
    "README.md",
    "sig/oauth2.rbs",
  ].select { |path| File.exist?(File.join(gemspec_root, path)) }

  # Specify which files are part of the released package.
  spec.files = [
    # Root package metadata
    *package_metadata_files,
    # Code / tasks / data (NOTE: exe/ is specified via spec.bindir and spec.executables below)
    *enumerate_package_files.call("lib"),
    # Executables and executable support scripts
    *enumerate_package_files.call("exe"),
    *enumerate_package_glob.call(File.join(gemspec_root, "lib/**/*")),
    *enumerate_package_glob.call(File.join(gemspec_root, "LICENSE")),
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
  spec.bindir = "exe"
  # Listed files are the relative paths from bindir above.
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", [">= 0.17.3", "< 3.0"]
  spec.add_dependency "jwt", [">= 1.0", "< 3.0"]
  spec.add_dependency "multi_json", "~> 1.3"
  spec.add_dependency "multi_xml", "~> 0.5"
  spec.add_dependency "rack", [">= 1.2", "< 4"]

  # NOTE: It is preferable to list development dependencies in the gemspec due to increased
  #       visibility and discoverability.
  #       However, development dependencies in gemspec will install on
  #       all versions of Ruby that will run in CI.
  #       This gem, and its gemspec runtime dependencies, will install on Ruby down to 1.9.0.
  #       This gem, and its gemspec development dependencies, will install on Ruby down to 2.4.
  #       Thus, dev dependencies in gemspec must have
  #
  #       required_ruby_version ">= 2.4" (or lower)
  #
  #       Development dependencies that require strictly newer Ruby versions should be in a "gemfile",
  #       and preferably a modular one (see gemfiles/modular/*.gemfile).

  # Dev, Test, & Release Tasks
  spec.add_development_dependency("kettle-dev", "~> 3.1", ">= 3.1.25")             # ruby >= 2.4

  # Security
  spec.add_development_dependency("bundler-audit", "~> 0.9.3")                      # ruby >= 2.0.0

  # Tasks
  spec.add_development_dependency("rake", "~> 13.0")                                # ruby >= 2.2.0

  # Debugging
  spec.add_development_dependency("require_bench", "~> 1.0", ">= 1.0.4")            # ruby >= 2.2.0

  # Testing
  # Loads version files in anonymous namespaces for coverage without constant redefinition warnings.
  spec.add_development_dependency("anonymous_loader", "~> 0.1", ">= 0.1.5")         # ruby >= 2.2.0
  spec.add_development_dependency("appraisal2", "~> 3.2", ">= 3.2.6")               # ruby >= 1.8.7, for testing against multiple versions of dependencies
  spec.add_development_dependency("kettle-test", "~> 2.0", ">= 2.0.28")            # ruby >= 2.4
  spec.add_development_dependency("turbo_tests2", "~> 4.0", ">= 4.0.0")           # ruby >= 2.4.0, default kettle-test runner

  # Releasing
  spec.add_development_dependency("ruby-progressbar", "~> 1.13")                    # ruby >= 0
  spec.add_development_dependency("stone_checksums", "~> 1.0", ">= 1.0.9")          # ruby >= 2.2.0

  # Development tasks
  # The cake is a lie. erb v2.2, the oldest release, was never compatible with Ruby 2.3.
  # This means we have no choice but to use the erb that shipped with Ruby 2.3
  # /opt/hostedtoolcache/Ruby/2.3.8/x64/lib/ruby/gems/2.3.0/gems/erb-2.2.2/lib/erb.rb:670:in `prepare_trim_mode': undefined method `match?' for "-":String (NoMethodError)
  # spec.add_development_dependency("erb", ">= 2.2")                                  # ruby >= 2.3.0, not SemVer, old rubies get dropped in a patch.
  spec.add_development_dependency("gitmoji-regex", "~> 2.0", ">= 2.0.15")            # ruby >= 2.4

  # HTTP recording for deterministic specs
  # In Ruby 3.5 (HEAD) the CGI library has been pared down, so we also need to depend on gem "cgi" for ruby@head
  # This is done in the "head" appraisal.
  # See: https://github.com/vcr/vcr/issues/1057
  # spec.add_development_dependency("vcr", ">= 4")                        # 6.0 claims to support ruby >= 2.3, but fails on ruby 2.4
  # spec.add_development_dependency("webmock", ">= 3")                    # Last version to support ruby >= 2.3
  spec.add_development_dependency "addressable", ">= 2"
  spec.add_development_dependency "bundler", ">= 1.16"
  spec.add_development_dependency "rexml", ">= 3"
  spec.add_development_dependency "rspec", ">= 3"
  spec.add_development_dependency "rspec-block_is_expected"
  spec.add_development_dependency "rspec-pending_for"
  spec.add_development_dependency "rspec-stubbed_env", ">= 1.0.17"
  spec.add_development_dependency "silent_stream"
end
