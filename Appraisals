# frozen_string_literal: true

# HOW TO UPDATE APPRAISALS (will run rubocop_gradual's autocorrect afterward):
#   bin/rake appraisals:update

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
  eval_gemfile "modular/x_std_libs.gemfile"
end

# Used for head (nightly) releases of ruby, truffleruby, and jruby.
# Split into discrete appraisals if one of them needs a dependency locked discretely.
appraise "head" do
  # Why is gem "cgi" here? See: https://github.com/vcr/vcr/issues/1057
  gem "cgi", ">= 0.5"
  gem "benchmark", "~> 0.4", ">= 0.4.1"
  eval_gemfile "modular/runtime_heads.gemfile"
end

# Used for current releases of ruby, truffleruby, and jruby.
# Split into discrete appraisals if one of them needs a dependency locked discretely.
appraise "current" do
  eval_gemfile "modular/x_std_libs.gemfile"
end

# Test current Rubies against head versions of runtime dependencies
appraise "dep-heads" do
  eval_gemfile "modular/runtime_heads.gemfile"
end

appraise "ruby-2-4" do
  eval_gemfile "modular/faraday_v1.gemfile"
  eval_gemfile "modular/hashie_v1.gemfile"
  eval_gemfile "modular/jwt_v1.gemfile"
  eval_gemfile "modular/logger_v1_2.gemfile"
  eval_gemfile "modular/multi_xml_v0_5.gemfile"
  eval_gemfile "modular/rack_v1_6.gemfile"
  eval_gemfile "modular/x_std_libs/r2.4/libs.gemfile"
end

appraise "ruby-2-5" do
  eval_gemfile "modular/faraday_v1.gemfile"
  eval_gemfile "modular/hashie_v2.gemfile"
  eval_gemfile "modular/jwt_v2.gemfile"
  eval_gemfile "modular/logger_v1_5.gemfile"
  eval_gemfile "modular/multi_xml_v0_6.gemfile"
  eval_gemfile "modular/rack_v2.gemfile"
  eval_gemfile "modular/x_std_libs/r2.6/libs.gemfile"
end

appraise "ruby-2-6" do
  eval_gemfile "modular/faraday_v2.gemfile"
  eval_gemfile "modular/hashie_v3.gemfile"
  eval_gemfile "modular/jwt_v2.gemfile"
  eval_gemfile "modular/logger_v1_5.gemfile"
  eval_gemfile "modular/multi_xml_v0_6.gemfile"
  eval_gemfile "modular/rack_v3.gemfile"
  eval_gemfile "modular/x_std_libs/r2.6/libs.gemfile"
end

appraise "ruby-2-7" do
  eval_gemfile "modular/faraday_v2.gemfile"
  eval_gemfile "modular/hashie_v4.gemfile"
  eval_gemfile "modular/jwt_v2.gemfile"
  eval_gemfile "modular/logger_v1_7.gemfile"
  eval_gemfile "modular/multi_xml_v0_6.gemfile"
  eval_gemfile "modular/rack_v3.gemfile"
  eval_gemfile "modular/x_std_libs/r2/libs.gemfile"
end

appraise "ruby-3-0" do
  eval_gemfile "modular/faraday_v2.gemfile"
  eval_gemfile "modular/hashie_v5.gemfile"
  eval_gemfile "modular/jwt_v2.gemfile"
  eval_gemfile "modular/logger_v1_7.gemfile"
  eval_gemfile "modular/multi_xml_v0_6.gemfile"
  eval_gemfile "modular/rack_v3.gemfile"
  eval_gemfile "modular/x_std_libs/r3.1/libs.gemfile"
end

appraise "ruby-3-1" do
  eval_gemfile "modular/faraday_v2.gemfile"
  eval_gemfile "modular/hashie_v5.gemfile"
  eval_gemfile "modular/jwt_v2.gemfile"
  eval_gemfile "modular/logger_v1_7.gemfile"
  eval_gemfile "modular/multi_xml_v0_6.gemfile"
  eval_gemfile "modular/rack_v3.gemfile"
  eval_gemfile "modular/x_std_libs/r3.1/libs.gemfile"
end

appraise "ruby-3-2" do
  eval_gemfile "modular/faraday_v2.gemfile"
  eval_gemfile "modular/hashie_v5.gemfile"
  eval_gemfile "modular/jwt_v2.gemfile"
  eval_gemfile "modular/logger_v1_7.gemfile"
  eval_gemfile "modular/multi_xml_v0_7.gemfile"
  eval_gemfile "modular/rack_v3.gemfile"
  eval_gemfile "modular/x_std_libs/r3/libs.gemfile"
end

appraise "ruby-3-3" do
  eval_gemfile "modular/faraday_v2.gemfile"
  eval_gemfile "modular/hashie_v5.gemfile"
  eval_gemfile "modular/jwt_v2.gemfile"
  eval_gemfile "modular/logger_v1_7.gemfile"
  eval_gemfile "modular/multi_xml_v0_7.gemfile"
  eval_gemfile "modular/rack_v3.gemfile"
  eval_gemfile "modular/x_std_libs/r3/libs.gemfile"
end

# Only run security audit on the latest version of Ruby
appraise "audit" do
  eval_gemfile "modular/audit.gemfile"
  eval_gemfile "modular/faraday_v2.gemfile"
  eval_gemfile "modular/hashie_v5.gemfile"
  eval_gemfile "modular/jwt_v2.gemfile"
  eval_gemfile "modular/logger_v1_7.gemfile"
  eval_gemfile "modular/multi_xml_v0_7.gemfile"
  eval_gemfile "modular/rack_v3.gemfile"
  eval_gemfile "modular/x_std_libs.gemfile"
end

# Only run coverage on the latest version of Ruby
appraise "coverage" do
  eval_gemfile "modular/coverage.gemfile"
  eval_gemfile "modular/faraday_v2.gemfile"
  eval_gemfile "modular/hashie_v5.gemfile"
  eval_gemfile "modular/jwt_v2.gemfile"
  eval_gemfile "modular/logger_v1_7.gemfile"
  eval_gemfile "modular/multi_xml_v0_7.gemfile"
  eval_gemfile "modular/optional.gemfile"
  eval_gemfile "modular/rack_v3.gemfile"
  eval_gemfile "modular/x_std_libs.gemfile"
end

# Only run linter on the latest version of Ruby (but, in support of oldest supported Ruby version)
appraise "style" do
  eval_gemfile "modular/style.gemfile"
  eval_gemfile "modular/x_std_libs.gemfile"
end

appraise "ruby-2-3-hashie_v0" do
  eval_gemfile "modular/faraday_v0.gemfile"
  eval_gemfile "modular/hashie_v0.gemfile"
  eval_gemfile "modular/jwt_v1.gemfile"
  eval_gemfile "modular/logger_v1_2.gemfile"
  eval_gemfile "modular/multi_xml_v0_5.gemfile"
  eval_gemfile "modular/rack_v1_2.gemfile"
  eval_gemfile "modular/x_std_libs/r2.3/libs.gemfile"
end

appraise "ruby-2-3-hashie_v1" do
  eval_gemfile "modular/faraday_v0.gemfile"
  eval_gemfile "modular/hashie_v1.gemfile"
  eval_gemfile "modular/jwt_v1.gemfile"
  eval_gemfile "modular/logger_v1_2.gemfile"
  eval_gemfile "modular/multi_xml_v0_5.gemfile"
  eval_gemfile "modular/rack_v1_2.gemfile"
  eval_gemfile "modular/x_std_libs/r2.3/libs.gemfile"
end

appraise "ruby-2-3-hashie_v2" do
  eval_gemfile "modular/faraday_v0.gemfile"
  eval_gemfile "modular/hashie_v2.gemfile"
  eval_gemfile "modular/jwt_v1.gemfile"
  eval_gemfile "modular/logger_v1_2.gemfile"
  eval_gemfile "modular/multi_xml_v0_5.gemfile"
  eval_gemfile "modular/rack_v1_2.gemfile"
  eval_gemfile "modular/x_std_libs/r2.3/libs.gemfile"
end

appraise "ruby-2-3-hashie_v3" do
  eval_gemfile "modular/faraday_v0.gemfile"
  eval_gemfile "modular/hashie_v3.gemfile"
  eval_gemfile "modular/jwt_v1.gemfile"
  eval_gemfile "modular/logger_v1_2.gemfile"
  eval_gemfile "modular/multi_xml_v0_5.gemfile"
  eval_gemfile "modular/rack_v1_2.gemfile"
  eval_gemfile "modular/x_std_libs/r2.3/libs.gemfile"
end

appraise "ruby-2-3-hashie_v4" do
  eval_gemfile "modular/faraday_v0.gemfile"
  eval_gemfile "modular/hashie_v4.gemfile"
  eval_gemfile "modular/jwt_v1.gemfile"
  eval_gemfile "modular/logger_v1_2.gemfile"
  eval_gemfile "modular/multi_xml_v0_5.gemfile"
  eval_gemfile "modular/rack_v1_2.gemfile"
  eval_gemfile "modular/x_std_libs/r2.3/libs.gemfile"
end

appraise "ruby-2-3-hashie_v5" do
  eval_gemfile "modular/faraday_v0.gemfile"
  eval_gemfile "modular/hashie_v5.gemfile"
  eval_gemfile "modular/jwt_v1.gemfile"
  eval_gemfile "modular/logger_v1_2.gemfile"
  eval_gemfile "modular/multi_xml_v0_5.gemfile"
  eval_gemfile "modular/rack_v1_2.gemfile"
  eval_gemfile "modular/x_std_libs/r2.3/libs.gemfile"
end
