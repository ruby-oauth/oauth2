# frozen_string_literal: true

# kettle-jem:freeze
# To retain chunks of comments & code during oauth2 templating:
# Wrap custom sections with freeze markers (e.g., as above and below this comment chunk).
# oauth2 will then preserve content between those markers across template runs.
# kettle-jem:unfreeze

# HOW TO UPDATE APPRAISALS (will run rubocop_gradual's autocorrect afterward):
#   bin/rake appraisal:update

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
  # Seems to be an undeclared dependency of yard.
  # /opt/hostedtoolcache/Ruby/4.0.0/x64/lib/ruby/gems/4.0.0/gems/yard-0.9.38/lib/yard/parser/ruby/legacy/irb/slex.rb:13: warning: irb/notifier is found in irb, which is not part of the default gems since Ruby 4.0.0.
  # You can add irb to your Gemfile or gemspec to fix this error.
  # rake aborted!
  # LoadError: cannot load such file -- irb/notifier (LoadError)
  # /opt/hostedtoolcache/Ruby/4.0.0/x64/bin/bundle:25:in '<main>'
  # But it won't install on TruffleRuby, so it can't be part of modular gemfiles used there:
  # An error occurred while installing psych (5.3.1), and Bundler cannot continue.
  #
  # In ruby_3_2.gemfile:
  #   irb was resolved to 1.16.0, which depends on
  #     rdoc was resolved to 7.0.3, which depends on
  #       psych
  gem "irb", "~> 1.17" # ruby >= 2.7

  eval_gemfile "modular/coverage.gemfile"
  eval_gemfile "modular/documentation.gemfile"
  eval_gemfile "modular/optional.gemfile"
  eval_gemfile "modular/style.gemfile"
  eval_gemfile "modular/x_std_libs.gemfile"
end

appraise "head" do
  eval_gemfile "modular/x_std_libs.gemfile"
  gem "benchmark", "~> 0.4", ">= 0.4.1"
  eval_gemfile "modular/runtime_heads.gemfile"
end

appraise "current" do
  eval_gemfile "modular/x_std_libs.gemfile"
end

appraise "dep-heads" do
  eval_gemfile "modular/runtime_heads.gemfile"
end

appraise "ruby-2-4" do
  eval_gemfile "modular/x_std_libs/r2.4/libs.gemfile"
  eval_gemfile "modular/faraday_v1.gemfile"
  eval_gemfile "modular/hashie_v1.gemfile"
  eval_gemfile "modular/jwt_v1.gemfile"
  eval_gemfile "modular/logger_v1_2.gemfile"
  eval_gemfile "modular/multi_xml_v0_5.gemfile"
  eval_gemfile "modular/rack_v1_6.gemfile"
end

appraise "ruby-2-5" do
  eval_gemfile "modular/x_std_libs/r2.6/libs.gemfile"
  eval_gemfile "modular/faraday_v1.gemfile"
  eval_gemfile "modular/hashie_v2.gemfile"
  eval_gemfile "modular/jwt_v2.gemfile"
  eval_gemfile "modular/logger_v1_5.gemfile"
  eval_gemfile "modular/multi_xml_v0_6.gemfile"
  eval_gemfile "modular/rack_v2.gemfile"
end

appraise "ruby-2-6" do
  eval_gemfile "modular/x_std_libs/r2.6/libs.gemfile"
  eval_gemfile "modular/faraday_v2.gemfile"
  eval_gemfile "modular/hashie_v3.gemfile"
  eval_gemfile "modular/jwt_v2.gemfile"
  eval_gemfile "modular/logger_v1_5.gemfile"
  eval_gemfile "modular/multi_xml_v0_6.gemfile"
  eval_gemfile "modular/rack_v3.gemfile"
end

appraise "ruby-2-7" do
  eval_gemfile "modular/x_std_libs/r2/libs.gemfile"
  eval_gemfile "modular/faraday_v2.gemfile"
  eval_gemfile "modular/hashie_v4.gemfile"
  eval_gemfile "modular/jwt_v2.gemfile"
  eval_gemfile "modular/logger_v1_7.gemfile"
  eval_gemfile "modular/multi_xml_v0_6.gemfile"
  eval_gemfile "modular/rack_v3.gemfile"
end

appraise "ruby-3-0" do
  eval_gemfile "modular/json/truffleruby_22_3.gemfile"
  eval_gemfile "modular/json/truffleruby_23_0.gemfile"
  eval_gemfile "modular/x_std_libs/r3.1/libs.gemfile"
  eval_gemfile "modular/faraday_v2.gemfile"
  eval_gemfile "modular/hashie_v5.gemfile"
  eval_gemfile "modular/jwt_v2.gemfile"
  eval_gemfile "modular/logger_v1_7.gemfile"
  eval_gemfile "modular/multi_xml_v0_6.gemfile"
  eval_gemfile "modular/rack_v3.gemfile"
end

appraise "ruby-3-1" do
  eval_gemfile "modular/x_std_libs/r3.1/libs.gemfile"
  eval_gemfile "modular/faraday_v2.gemfile"
  eval_gemfile "modular/hashie_v5.gemfile"
  eval_gemfile "modular/jwt_v2.gemfile"
  eval_gemfile "modular/logger_v1_7.gemfile"
  eval_gemfile "modular/multi_xml_v0_6.gemfile"
  eval_gemfile "modular/rack_v3.gemfile"
end

appraise "ruby-3-2" do
  eval_gemfile "modular/json/truffleruby_23_1.gemfile"
  eval_gemfile "modular/x_std_libs/r3/libs.gemfile"
  eval_gemfile "modular/faraday_v2.gemfile"
  eval_gemfile "modular/hashie_v5.gemfile"
  eval_gemfile "modular/jwt_v2.gemfile"
  eval_gemfile "modular/logger_v1_7.gemfile"
  eval_gemfile "modular/multi_xml_v0_7.gemfile"
  eval_gemfile "modular/rack_v3.gemfile"
end

appraise "ruby-3-3" do
  eval_gemfile "modular/x_std_libs/r3/libs.gemfile"
  eval_gemfile "modular/faraday_v2.gemfile"
  eval_gemfile "modular/hashie_v5.gemfile"
  eval_gemfile "modular/jwt_v2.gemfile"
  eval_gemfile "modular/logger_v1_7.gemfile"
  eval_gemfile "modular/multi_xml_v0_7.gemfile"
  eval_gemfile "modular/rack_v3.gemfile"
end

appraise "ruby-3-4" do
  eval_gemfile "modular/x_std_libs/r3/libs.gemfile"
end

appraise "audit" do
  eval_gemfile "modular/x_std_libs.gemfile"
  eval_gemfile "modular/audit.gemfile"
  eval_gemfile "modular/faraday_v2.gemfile"
  eval_gemfile "modular/hashie_v5.gemfile"
  eval_gemfile "modular/jwt_v2.gemfile"
  eval_gemfile "modular/logger_v1_7.gemfile"
  eval_gemfile "modular/multi_xml_v0_7.gemfile"
  eval_gemfile "modular/rack_v3.gemfile"
end

appraise "coverage" do
  eval_gemfile "modular/coverage.gemfile"
  eval_gemfile "modular/optional.gemfile"
  eval_gemfile "modular/x_std_libs.gemfile"
  eval_gemfile "modular/faraday_v2.gemfile"
  eval_gemfile "modular/hashie_v5.gemfile"
  eval_gemfile "modular/jwt_v2.gemfile"
  eval_gemfile "modular/logger_v1_7.gemfile"
  eval_gemfile "modular/multi_xml_v0_7.gemfile"
  eval_gemfile "modular/rack_v3.gemfile"
end

appraise "style" do
  eval_gemfile "modular/style.gemfile"
  eval_gemfile "modular/x_std_libs.gemfile"
end

appraise "templating" do
  eval_gemfile "modular/templating.gemfile"
  eval_gemfile "modular/x_std_libs.gemfile"
end
