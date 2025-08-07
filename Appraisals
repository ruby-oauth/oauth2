# frozen_string_literal: true

# HOW TO UPDATE APPRAISALS:
#   BUNDLE_GEMFILE=Appraisal.root.gemfile bundle
#   BUNDLE_GEMFILE=Appraisal.root.gemfile bundle exec appraisal update

# Lock/Unlock Deps Pattern
#
# Two often conflicting goals resolved!
#
#  - deps_unlocked.yml
#    - All runtime & dev dependencies, but does not have a `gemfiles/*.gemfile.lock` committed
#    - Uses an Appraisal2 "deps_unlocked" gemfile, and the current MRI Ruby release
#    - Know when new dependency releases will break local dev with unlocked dependencies
#    - Broken workflow indicates that new releases of dependencies may not work
#
#  - deps_locked.yml
#    - All runtime & dev dependencies, and has a `Gemfile.lock` committed
#    - Uses the project's main Gemfile, and the current MRI Ruby release
#    - Matches what contributors and maintainers use locally for development
#    - Broken workflow indicates that a new contributor will have a bad time
#
appraise "deps_unlocked" do
  eval_gemfile "modular/audit.gemfile"
  eval_gemfile "modular/coverage.gemfile"
  eval_gemfile "modular/documentation.gemfile"
  eval_gemfile "modular/style.gemfile"
end

# Used for HEAD (nightly) releases of ruby, truffleruby, and jruby.
# Split into discrete appraisals if one of them needs a dependency locked discretely.
appraise "head" do
  gem "mutex_m", ">= 0.2"
  gem "stringio", ">= 3.0"
  eval_gemfile "modular/runtime_heads.gemfile"
end

# Test current Rubies against head versions of runtime dependencies
appraise "current-runtime-heads" do
  gem "mutex_m", ">= 0.2"
  gem "stringio", ">= 3.0"
  eval_gemfile "modular/runtime_heads.gemfile"
end

# Used for current releases of ruby, truffleruby, and jruby.
# Split into discrete appraisals if one of them needs a dependency locked discretely.
appraise "current" do
  eval_gemfile "modular/latest.gemfile"
end

appraise "ruby-2-3-hashie_v0" do
  eval_gemfile "modular/faraday_v0.gemfile"
  eval_gemfile "modular/hashie_v0.gemfile"
  eval_gemfile "modular/jwt_v1.gemfile"
  eval_gemfile "modular/logger_v1_2.gemfile"
  eval_gemfile "modular/multi_xml_v0_5.gemfile"
  eval_gemfile "modular/rack_v1_2.gemfile"
end

appraise "ruby-2-3-hashie_v1" do
  eval_gemfile "modular/faraday_v0.gemfile"
  eval_gemfile "modular/hashie_v1.gemfile"
  eval_gemfile "modular/jwt_v1.gemfile"
  eval_gemfile "modular/logger_v1_2.gemfile"
  eval_gemfile "modular/multi_xml_v0_5.gemfile"
  eval_gemfile "modular/rack_v1_2.gemfile"
end

appraise "ruby-2-3-hashie_v2" do
  eval_gemfile "modular/faraday_v0.gemfile"
  eval_gemfile "modular/hashie_v2.gemfile"
  eval_gemfile "modular/jwt_v1.gemfile"
  eval_gemfile "modular/logger_v1_2.gemfile"
  eval_gemfile "modular/multi_xml_v0_5.gemfile"
  eval_gemfile "modular/rack_v1_2.gemfile"
end

appraise "ruby-2-3-hashie_v3" do
  eval_gemfile "modular/faraday_v0.gemfile"
  eval_gemfile "modular/hashie_v3.gemfile"
  eval_gemfile "modular/jwt_v1.gemfile"
  eval_gemfile "modular/logger_v1_2.gemfile"
  eval_gemfile "modular/multi_xml_v0_5.gemfile"
  eval_gemfile "modular/rack_v1_2.gemfile"
end

appraise "ruby-2-3-hashie_v4" do
  eval_gemfile "modular/faraday_v0.gemfile"
  eval_gemfile "modular/hashie_v4.gemfile"
  eval_gemfile "modular/jwt_v1.gemfile"
  eval_gemfile "modular/logger_v1_2.gemfile"
  eval_gemfile "modular/multi_xml_v0_5.gemfile"
  eval_gemfile "modular/rack_v1_2.gemfile"
end

appraise "ruby-2-3-hashie_v5" do
  eval_gemfile "modular/faraday_v0.gemfile"
  eval_gemfile "modular/hashie_v5.gemfile"
  eval_gemfile "modular/jwt_v1.gemfile"
  eval_gemfile "modular/logger_v1_2.gemfile"
  eval_gemfile "modular/multi_xml_v0_5.gemfile"
  eval_gemfile "modular/rack_v1_2.gemfile"
end

appraise "ruby-2-4" do
  eval_gemfile "modular/faraday_v1.gemfile"
  eval_gemfile "modular/hashie_v1.gemfile"
  eval_gemfile "modular/jwt_v1.gemfile"
  eval_gemfile "modular/logger_v1_2.gemfile"
  eval_gemfile "modular/multi_xml_v0_5.gemfile"
  eval_gemfile "modular/rack_v1_6.gemfile"
end

appraise "ruby-2-5" do
  eval_gemfile "modular/faraday_v1.gemfile"
  eval_gemfile "modular/hashie_v2.gemfile"
  eval_gemfile "modular/jwt_v2.gemfile"
  eval_gemfile "modular/logger_v1_5.gemfile"
  eval_gemfile "modular/multi_xml_v0_6.gemfile"
  eval_gemfile "modular/rack_v2.gemfile"
end

appraise "ruby-2-6" do
  gem "mutex_m", "~> 0.2"
  gem "stringio", "~> 3.0"
  eval_gemfile "modular/faraday_v2.gemfile"
  eval_gemfile "modular/hashie_v3.gemfile"
  eval_gemfile "modular/jwt_v2.gemfile"
  eval_gemfile "modular/logger_v1_5.gemfile"
  eval_gemfile "modular/multi_xml_v0_6.gemfile"
  eval_gemfile "modular/rack_v3.gemfile"
end

appraise "ruby-2-7" do
  gem "mutex_m", "~> 0.2"
  gem "stringio", "~> 3.0"
  eval_gemfile "modular/faraday_v2.gemfile"
  eval_gemfile "modular/hashie_v4.gemfile"
  eval_gemfile "modular/jwt_v2.gemfile"
  eval_gemfile "modular/logger_v1_7.gemfile"
  eval_gemfile "modular/multi_xml_v0_6.gemfile"
  eval_gemfile "modular/rack_v3.gemfile"
end

appraise "ruby-3-0" do
  gem "mutex_m", "~> 0.2"
  gem "stringio", "~> 3.0"
  eval_gemfile "modular/faraday_v2.gemfile"
  eval_gemfile "modular/hashie_v5.gemfile"
  eval_gemfile "modular/jwt_v2.gemfile"
  eval_gemfile "modular/logger_v1_7.gemfile"
  eval_gemfile "modular/multi_xml_v0_6.gemfile"
  eval_gemfile "modular/rack_v3.gemfile"
end

appraise "ruby-3-1" do
  gem "mutex_m", "~> 0.2"
  gem "stringio", "~> 3.0"
  eval_gemfile "modular/faraday_v2.gemfile"
  eval_gemfile "modular/hashie_v5.gemfile"
  eval_gemfile "modular/jwt_v2.gemfile"
  eval_gemfile "modular/logger_v1_7.gemfile"
  eval_gemfile "modular/multi_xml_v0_6.gemfile"
  eval_gemfile "modular/rack_v3.gemfile"
end

appraise "ruby-3-2" do
  gem "mutex_m", "~> 0.2"
  gem "stringio", "~> 3.0"
  eval_gemfile "modular/faraday_v2.gemfile"
  eval_gemfile "modular/hashie_v5.gemfile"
  eval_gemfile "modular/jwt_v2.gemfile"
  eval_gemfile "modular/logger_v1_7.gemfile"
  eval_gemfile "modular/multi_xml_v0_7.gemfile"
  eval_gemfile "modular/rack_v3.gemfile"
end

appraise "ruby-3-3" do
  gem "mutex_m", "~> 0.2"
  gem "stringio", "~> 3.0"
  eval_gemfile "modular/faraday_v2.gemfile"
  eval_gemfile "modular/hashie_v5.gemfile"
  eval_gemfile "modular/jwt_v2.gemfile"
  eval_gemfile "modular/logger_v1_7.gemfile"
  eval_gemfile "modular/multi_xml_v0_7.gemfile"
  eval_gemfile "modular/rack_v3.gemfile"
end

# Only run security audit on the latest version of Ruby
appraise "audit" do
  gem "mutex_m", "~> 0.2"
  gem "stringio", "~> 3.0"
  eval_gemfile "modular/audit.gemfile"
  eval_gemfile "modular/faraday_v2.gemfile"
  eval_gemfile "modular/hashie_v5.gemfile"
  eval_gemfile "modular/jwt_v2.gemfile"
  eval_gemfile "modular/logger_v1_7.gemfile"
  eval_gemfile "modular/multi_xml_v0_7.gemfile"
  eval_gemfile "modular/rack_v3.gemfile"
end

# Only run coverage on the latest version of Ruby
appraise "coverage" do
  gem "mutex_m", "~> 0.2"
  gem "stringio", "~> 3.0"
  eval_gemfile "modular/coverage.gemfile"
  eval_gemfile "modular/faraday_v2.gemfile"
  eval_gemfile "modular/hashie_v5.gemfile"
  eval_gemfile "modular/jwt_v2.gemfile"
  eval_gemfile "modular/logger_v1_7.gemfile"
  eval_gemfile "modular/multi_xml_v0_7.gemfile"
  eval_gemfile "modular/rack_v3.gemfile"
end

# Only run linter on the latest version of Ruby (but, in support of oldest supported Ruby version)
appraise "style" do
  gem "mutex_m", "~> 0.2"
  gem "stringio", "~> 3.0"
  eval_gemfile "modular/style.gemfile"
end

appraise "omnibus" do
  eval_gemfile "modular/audit.gemfile"
  eval_gemfile "modular/coverage.gemfile"
  eval_gemfile "modular/documentation.gemfile"
  eval_gemfile "modular/faraday_v2.gemfile"
  eval_gemfile "modular/hashie_v5.gemfile"
  eval_gemfile "modular/jwt_v2.gemfile"
  eval_gemfile "modular/logger_v1_7.gemfile"
  eval_gemfile "modular/multi_xml_v0_7.gemfile"
  eval_gemfile "modular/rack_v3.gemfile"
  eval_gemfile "modular/style.gemfile"
end

appraise "vanilla" do
end
