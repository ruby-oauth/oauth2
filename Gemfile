# frozen_string_literal: true

# kettle-jem:freeze
# To retain chunks of comments & code during kettle-jem templating:
# Wrap custom sections with freeze markers (e.g., as above and below this comment chunk).
# kettle-jem will then preserve content between those markers across template runs.
# kettle-jem:unfreeze

source "https://gem.coop"

git_source(:codeberg) { |repo_name| "https://codeberg.org/#{repo_name}" }
git_source(:gitlab) { |repo_name| "https://gitlab.com/#{repo_name}" }

#### IMPORTANT #######################################################
# Gemfile is for local development ONLY; Gemfile is NOT loaded in CI #
####################################################### IMPORTANT ####

# Include dependencies from oauth2.gemspec
gemspec

gem "kettle-family", "~> 1.3", ">= 1.3.34"

# Local workspace dependency wiring for *_local.gemfile overrides
gem "nomono", "~> 1.1", ">= 1.1.16", require: false # ruby >= 3.2.0

# Direct sibling dependencies (env-switched via RUBY_OAUTH_DEV)
direct_sibling_gems = %w[
  anonymous_loader
  auth-sanitizer
  snaky_hash
  version_gem
]
direct_sibling_dev = ENV.fetch("RUBY_OAUTH_DEV", "")
direct_sibling_local =
  !direct_sibling_dev.empty? && !%w[false 0 no off].include?(direct_sibling_dev.downcase)
direct_sibling_templating = ENV.fetch("K_JEM_TEMPLATING", "false").casecmp("true").zero?

if direct_sibling_gems.any? &&
    (direct_sibling_local ||
      ENV.fetch("K_JEM_TEMPLATING", "false").casecmp("true").zero?)
  direct_sibling_dev_was_set = ENV.key?("RUBY_OAUTH_DEV")
  direct_sibling_dev_original = ENV.fetch("RUBY_OAUTH_DEV", nil)
  # Bootstrapping nomono here cannot rely on a plain `gem "nomono", ...` line.
  # Bundler records that dependency during Gemfile evaluation, but it does not
  # activate that exact version before the immediate `require "nomono/bundler"`.
  nomono_activation_requirements = ["~> 1.1", ">= 1.1.15"]
  nomono_requirement = Gem::Requirement.new(nomono_activation_requirements)
  nomono_already_activated = Gem.loaded_specs["nomono"]
  nomono_lockfile = File.expand_path("Gemfile.lock", __dir__)
  nomono_locked_spec = nil
  if File.file?(nomono_lockfile)
    require "bundler"
    nomono_locked_spec = Bundler::LockfileParser.
      new(Bundler.read_file(nomono_lockfile)).
      specs.
      find { |spec| spec.name == "nomono" }
  end
  nomono_local_loader = if nomono_locked_spec && nomono_locked_spec.source.is_a?(Bundler::Source::Path)
    File.expand_path(
      File.join(nomono_locked_spec.source.path, "lib", "nomono", "bundler"),
      File.dirname(nomono_lockfile)
    )
  end
  if nomono_local_loader && File.file?("#{nomono_local_loader}.rb")
    require nomono_local_loader
  else
    if !nomono_already_activated || !nomono_requirement.satisfied_by?(nomono_already_activated.version)
      nomono_locked_installed = nomono_locked_spec &&
        Gem::Specification.find_all_by_name("nomono").any? { |spec| spec.version == nomono_locked_spec.version }
      nomono_locked = nomono_locked_spec &&
        nomono_locked_installed &&
        nomono_requirement.satisfied_by?(nomono_locked_spec.version)
      nomono_activation_requirements = ["= #{nomono_locked_spec.version}"] if nomono_locked
    end
    Kernel.send(:gem, "nomono", *nomono_activation_requirements)
    require "nomono/bundler"
  end
  begin
    ENV["RUBY_OAUTH_DEV"] = File.expand_path("..", __dir__) if direct_sibling_templating && !direct_sibling_local

    eval_nomono_gems(
      gems: direct_sibling_gems,
      requirements: {"anonymous_loader" => ["~> 0.1", ">= 0.1.3"], "auth-sanitizer" => ["~> 0.2", ">= 0.2.5"], "snaky_hash" => ["~> 2.0", ">= 2.0.7"], "version_gem" => ["~> 1.1", ">= 1.1.17"]},
      prefix: "RUBY_OAUTH",
      path_env: "RUBY_OAUTH_DEV",
      root: ["src", "my", "ruby-oauth"]
    )
  ensure
    if direct_sibling_templating && !direct_sibling_local
      if direct_sibling_dev_was_set
        ENV["RUBY_OAUTH_DEV"] = direct_sibling_dev_original
      else
        ENV.delete("RUBY_OAUTH_DEV")
      end
    end
  end
end

# Templating and the StructuredMerge family share this modular Gemfile.
# kettle-jem needs StructuredMerge to template, and kettle-changelog needs it at
# runtime (ast-crispr-markdown-markly -> markdown-merge -> tree_haver), so the
# test, lint, and release bundles resolve the family too. While the family is
# only partially released, registry copies pin the last published version exactly
# and cannot be satisfied alongside a local lockstep version, so a partial local
# wiring fails version solving for every command in the bundle.
#
# (env-switched: STRUCTUREDMERGE_DEV=/path/to/structuredmerge/ruby/gems for local paths)
eval_gemfile "gemfiles/modular/templating.gemfile" if
  ENV.fetch("K_JEM_TEMPLATING", "false").casecmp("true").zero? ||
    ENV.fetch("STRUCTUREDMERGE_DEV", "false").casecmp("false") != 0

# Debugging
eval_gemfile "gemfiles/modular/debug.gemfile"

# Code Coverage (env-switched: KETTLE_DEV_DEV=true for local paths)
eval_gemfile "gemfiles/modular/coverage.gemfile"

# Linting
eval_gemfile "gemfiles/modular/style.gemfile"

# Documentation
eval_gemfile "gemfiles/modular/documentation.gemfile"

# Changelog release tooling (available on Ruby versions supported by kettle-changelog)
eval_gemfile "gemfiles/modular/changelog.gemfile"

# Optional
eval_gemfile "gemfiles/modular/optional.gemfile"

### Std Lib Extracted Gems
eval_gemfile "gemfiles/modular/x_std_libs.gemfile"

# See unlocked_deps appraisal for more details on irb inclusion
gem "irb", "~> 1.17" # ruby >= 2.7
