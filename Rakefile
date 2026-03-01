# frozen_string_literal: true

# kettle-dev Rakefile v1.1.60 - 2025-11-23
# Ruby 2.3 (Safe Navigation) or higher required
#
# MIT License (see License.txt)
#
# Copyright (c) 2025 Peter H. Boling (galtzo.com)
#
# Expected to work in any project that uses Bundler.
#
# Sets up tasks for appraisal, floss_funding, rspec, minitest, rubocop, reek, yard, and stone_checksums.
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
# rake install                                # Build and install kettle-dev-1.0.0.gem in...
# rake install:local                          # Build and install kettle-dev-1.0.0.gem in...
# rake kettle:dev:install                     # Install kettle-dev GitHub automation and ...
# rake kettle:dev:template                    # Template kettle-dev files into the curren...
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

require "bundler/gem_tasks" if !Dir[File.join(__dir__, "*.gemspec")].empty?

# Define a base default task early so other files can enhance it.
desc "Default tasks aggregator"
task :default do
  puts "Default task complete."
end

# External gems that define tasks - add here!
require "kettle/dev"

### SPEC TASKS
# For coverage aggregation with SimpleCov merging:
# - Each task uses a unique K_SOUP_COV_COMMAND_NAME so SimpleCov tracks them separately
# - K_SOUP_COV_USE_MERGING=true must be set in .envrc for results to merge
# - K_SOUP_COV_MERGE_TIMEOUT should be set long enough for all tasks to complete
begin
  require "rspec/core/rake_task"

  # kettle-dev creates an RSpec::Core::RakeTask.new(:spec) which has both
  # prerequisites and actions. We will leave that, and the default test task, alone,
  # and use *magic* here.
  Rake::Task[:magic].clear if Rake::Task.task_defined?(:magic)
  desc("Run specs")
  RSpec::Core::RakeTask.new(:magic) do |t|
    t.pattern = "./spec/**/*_spec.rb"
  end

  desc("Set SimpleCov command name for remaining specs")
  task(:set_coverage_command_name) do
    ENV["K_SOUP_COV_COMMAND_NAME"] = "Test Coverage"
  end
  Rake::Task[:magic].enhance([:set_coverage_command_name])

  Rake::Task[:coverage].clear if Rake::Task.task_defined?(:coverage)
  desc("Slap magic onto the main coverage task")
  task(coverage: [:magic])
rescue LoadError
  desc("(stub) spec is unavailable")
  task(:spec) do # rubocop:disable Rake/DuplicateTask
    warn("NOTE: rspec isn't installed, or is disabled for #{RUBY_VERSION} in the current environment")
  end

  desc("(stub) test is unavailable")
  task(:test) do # rubocop:disable Rake/DuplicateTask
    warn("NOTE: rspec isn't installed, or is disabled for #{RUBY_VERSION} in the current environment")
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
