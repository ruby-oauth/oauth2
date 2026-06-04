# frozen_string_literal: true

# kettle-jem:freeze
# To retain chunks of comments & code during oauth2 templating:
# Wrap custom sections with freeze markers (e.g., as above and below this comment chunk).
# oauth2 will then preserve content between those markers across template runs.
# kettle-jem:unfreeze

# oauth2 Rakefile v7.0.0 - 2026-06-04
# Ruby 2.3 (Safe Navigation) or higher required
#
# See LICENSE.md for license information.
#
# Copyright (c) 2026 Peter H. Boling (galtzo.com)
#
# Expected to work in any project that uses Bundler.
#
# Sets up tasks for appraisal2, floss_funding, kettle-jem, kettle-dev, rspec, minitest, rubocop_gradual, reek, yard, and stone_checksums.
#
# rake appraisal:install                      # Install Appraisal gemfiles (initial setup...
# rake appraisal:reset                        # Delete Appraisal lockfiles (gemfiles/*.gemfile.lock)
# rake appraisal:update                       # Update Appraisal gemfiles and run RuboCop...
# rake bench                                  # Run all benchmarks (alias for bench:run)
# rake bench:list                             # List available benchmark scripts
# rake bench:run                              # Run all benchmark scripts (skips on CI)
# rake build:generate_checksums               # Generate both SHA256 & SHA512 checksums i...
# rake bundle:audit:check                     # Checks the Gemfile.lock for insecure depe...
# rake bundle:audit:update                    # Updates the bundler-audit vulnerability d...
# rake ci:act[opt]                            # Run 'act' with a selected workflow
# rake coverage                               # Run specs w/ coverage and open results in...
# rake default                                # Default tasks aggregator
# rake install                                # Build and install oauth2-1.0.0.gem in...
# rake install:local                          # Build and install oauth2-1.0.0.gem in...
# rake kettle:jem:install                     # Internal target used by `kettle-jem install`
# rake kettle:jem:selftest                    # Self-test: template oauth2 against itse...
# rake kettle:jem:template                    # Internal target used by scoped `kettle-jem template --only`
# rake reek                                   # Check for code smells
# rake reek:update                            # Run reek and store the output into the RE...
# rake release[remote]                        # Create tag v1.0.0 and build and push kett...
# rake rubocop_gradual                        # Run RuboCop Gradual
# rake rubocop_gradual:autocorrect            # Run RuboCop Gradual with autocorrect (onl...
# rake rubocop_gradual:autocorrect_all        # Run RuboCop Gradual with autocorrect (saf...
# rake rubocop_gradual:check                  # Run RuboCop Gradual to check the lock file
# rake rubocop_gradual:force_update           # Run RuboCop Gradual to force update the l...
# rake rubocop_gradual_debug                  # Run RuboCop Gradual
# rake rubocop_gradual_debug:autocorrect      # Run RuboCop Gradual with autocorrect (onl...
# rake rubocop_gradual_debug:autocorrect_all  # Run RuboCop Gradual with autocorrect (saf...
# rake rubocop_gradual_debug:check            # Run RuboCop Gradual to check the lock file
# rake rubocop_gradual_debug:force_update     # Run RuboCop Gradual to force update the l...
# rake spec                                   # Run RSpec code examples
# rake test                                   # Run tests
# rake yard                                   # Generate YARD Documentation
#

# :nocov:
require "bundler/gem_tasks" if !Dir[File.join(__dir__, "*.gemspec")].empty?
# :nocov:

# Define a base default task early so other files can enhance it.
desc "Default tasks aggregator"
task :default do
  puts "Default task complete."
end

# :nocov:
### MONOREPO FAMILY TASKS
if Dir.exist?(File.join(__dir__, "gems")) && Dir.exist?(File.join(__dir__, "workspace-scripts"))
  def family_script_path(script_name)
    File.join(__dir__, "workspace-scripts", script_name)
  end

  def run_family_script(script_name, *args)
    script = family_script_path(script_name)
    raise "Missing family script: #{script}" unless File.file?(script)

    command = [script, *args].compact
    sh(*command)
  end

  def family_gem_dirs
    Dir.glob(File.join(__dir__, "gems", "*", "*.gemspec"))
      .map { |path| File.dirname(path) }
      .uniq
      .sort_by { |path| File.basename(path) }
  end

  namespace :family do
    desc "List released Ruby subgems"
    task :list do
      family_gem_dirs.each { |path| puts File.basename(path) }
    end

    desc "Run release readiness checks for the Ruby gem family"
    task :readiness do
      run_family_script("10_release_readiness_check.rb")
    end

    desc "Run tests for the Ruby gem family"
    task :test do
      run_family_script("5_test_ruby_gems.sh")
    end

    desc "Run lint for the Ruby gem family"
    task :lint do
      run_family_script("4_lint_ruby_gems.sh")
    end

    desc "Generate YARD docs for the Ruby gem family"
    task :docs do
      run_family_script("6_docs_ruby_gems.sh")
    end

    desc "Run the Ruby gem family release planner"
    task :release do
      run_family_script("11_release_ruby_gems.rb")
    end

    desc "Execute the Ruby gem family release"
    task :release_execute do
      run_family_script("11_release_ruby_gems.rb", "--execute")
    end
  end
end
# :nocov:

# External gems that define tasks - add here!
begin
  require "kettle/dev"
  Kettle::Dev.install_tasks unless Kettle::Dev::RUNNING_AS == "rake"
rescue LoadError
  warn("NOTE: kettle-dev isn't installed, or is disabled for #{RUBY_VERSION} in the current environment")
end

### DUPLICATE DRIFT TASKS
begin
  require "kettle/drift"
  Kettle::Drift.install_tasks
rescue LoadError
  desc("(stub) kettle:drift:check is unavailable")
  task("kettle:drift:check") do
    warn("NOTE: kettle-drift isn't installed, or is disabled for #{RUBY_VERSION} in the current environment")
  end
  desc("(stub) kettle:drift:update is unavailable")
  task("kettle:drift:update") do
    warn("NOTE: kettle-drift isn't installed, or is disabled for #{RUBY_VERSION} in the current environment")
  end
  desc("(stub) kettle:drift:force_update is unavailable")
  task("kettle:drift:force_update") do
    warn("NOTE: kettle-drift isn't installed, or is disabled for #{RUBY_VERSION} in the current environment")
  end
  desc("(stub) kettle:drift is unavailable")
  task("kettle:drift" => "kettle:drift:update")
end

### TEMPLATING TASKS
# These tasks are installed for the `kettle-jem` executable. Run full templating
# through `kettle-jem install`; use `kettle-jem template --only PATH` only for
# scoped file updates. The executable prepares the environment and then
# delegates here when rake orchestration is needed.
kettle_jem_selftest_unavailable_note = nil
begin
  require "kettle/jem"
  if Kettle::Jem.respond_to?(:install_tasks)
    Kettle::Jem.install_tasks
  else
    kettle_jem_selftest_unavailable_note = "NOTE: kettle-jem #{Kettle::Jem::Version::VERSION} does not provide rake tasks in this environment"
  end
rescue LoadError
  kettle_jem_selftest_unavailable_note = "NOTE: kettle-jem isn't installed, or is disabled for #{RUBY_VERSION} in the current environment"
end

if kettle_jem_selftest_unavailable_note
  desc("(stub) kettle:jem:selftest is unavailable")
  task("kettle:jem:selftest") do
    warn(kettle_jem_selftest_unavailable_note)
  end
end

### RELEASE TASKS
# Setup stone_checksums
begin
  require "stone_checksums"
rescue LoadError
  desc("(stub) build:generate_checksums is unavailable")
  task("build:generate_checksums") do
    warn("NOTE: stone_checksums isn't installed, or is disabled for #{RUBY_VERSION} in the current environment")
  end
end
