# frozen_string_literal: true

# HOW TO UPDATE APPRAISALS:
#   BUNDLE_GEMFILE=Appraisal.root.gemfile bundle
#   BUNDLE_GEMFILE=Appraisal.root.gemfile bundle exec appraisal update
#   bundle exec rake rubocop_gradual:autocorrect

# Lock/Unlock Deps Pattern
#
# Two often conflicting goals resolved!
#
#  - unlocked_deps.yml
#    - All runtime & dev dependencies, but does not have a `gemfiles/*.gemfile.lock` committed
#    - Uses an Appraisal2 "unlocked_deps" gemfile, and the current MRI Ruby release
#    - Know when new dependency releases will break local dev with unlocked dependencies
#    - Broken workflow indicates that new releases of dependencies may not work
#
#  - locked_deps.yml
#    - All runtime & dev dependencies, and has a `Gemfile.lock` committed
#    - Uses the project's main Gemfile, and the current MRI Ruby release
#    - Matches what contributors and maintainers use locally for development
#    - Broken workflow indicates that a new contributor will have a bad time
#
appraise "unlocked_deps" do
  eval_gemfile "modular/coverage.gemfile"
  eval_gemfile "modular/documentation.gemfile"
  eval_gemfile "modular/style.gemfile"
  eval_gemfile "modular/optional.gemfile"
end

# Used for head (nightly) releases of ruby, truffleruby, and jruby.
# Split into discrete appraisals if one of them needs a dependency locked discretely.
appraise "head" do
  gem "mutex_m", ">= 0.2"
  gem "stringio", ">= 3.0"
  gem "benchmark", "~> 0.4", ">= 0.4.1"
end

# Used for current releases of ruby, truffleruby, and jruby.
# Split into discrete appraisals if one of them needs a dependency locked discretely.
appraise "current" do
  gem "mutex_m", ">= 0.2"
  gem "stringio", ">= 3.0"
end

appraise "ruby-2-3" do
end

appraise "ruby-2-4" do
end

appraise "ruby-2-5" do
end

appraise "ruby-2-6" do
  gem "mutex_m", "~> 0.2"
  gem "stringio", "~> 3.0"
end

appraise "ruby-2-7" do
  gem "mutex_m", "~> 0.2"
  gem "stringio", "~> 3.0"
end

appraise "ruby-3-0" do
  gem "mutex_m", "~> 0.2"
  gem "stringio", "~> 3.0"
end

appraise "ruby-3-1" do
  gem "mutex_m", "~> 0.2"
  gem "stringio", "~> 3.0"
end

appraise "ruby-3-2" do
  gem "mutex_m", "~> 0.2"
  gem "stringio", "~> 3.0"
end

appraise "ruby-3-3" do
  gem "mutex_m", "~> 0.2"
  gem "stringio", "~> 3.0"
end

# Only run security audit on the latest version of Ruby
appraise "audit" do
  gem "mutex_m", "~> 0.2"
  gem "stringio", "~> 3.0"
end

# Only run coverage on the latest version of Ruby
appraise "coverage" do
  gem "mutex_m", "~> 0.2"
  gem "stringio", "~> 3.0"
  eval_gemfile "modular/coverage.gemfile"
  eval_gemfile "modular/optional.gemfile"
end

# Only run linter on the latest version of Ruby (but, in support of oldest supported Ruby version)
appraise "style" do
  gem "mutex_m", "~> 0.2"
  gem "stringio", "~> 3.0"
  eval_gemfile "modular/style.gemfile"
end
