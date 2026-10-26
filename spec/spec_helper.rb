# frozen_string_literal: true

# Config for development dependencies of this library
# i.e., not configured by this library
#
# SimpleCov & related config (must run BEFORE any other requires)
RUN_COVERAGE = ENV["CI_CODECOV"] || ENV["CI"].nil?
VERBS = %i[get post put delete].freeze

# NOTE: Gemfiles for non-coverage appraisals may not have kettle-soup-cover.
#       The rescue LoadError handles that scenario.
begin
  require "kettle-soup-cover"
  if Kettle::Soup::Cover::DO_COV
    # Requiring simplecov loads the project-local `.simplecov`.
    require "simplecov"
    require "kettle/soup/cover/config"
    SimpleCov.start
  end
rescue LoadError => error
  # check the error message and re-raise when unexpected
  raise error unless error.message.include?("kettle")
end

# External RSpec & related config
require "addressable/uri"
require "kettle/test/rspec"
# `kettle/test/rspec` installs harness helpers documented in spec/README.md.

# This library
require "oauth2"

RSpec.configure do |config|
  config.expose_dsl_globally = true
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
