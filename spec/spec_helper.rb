# frozen_string_literal: true

# ensure test env
ENV["RACK_ENV"] = "test"

# Global Extensions
require_relative "ext/backports"

# External libraries
require "addressable/uri"
require "rspec/pending_for"

# Family libraries
require "kettle/test/rspec"

# Library Configs
require_relative "config/debug"
require_relative "config/multi_xml"
require_relative "config/faraday"
require_relative "config/constants"

# NOTE: Gemfiles for older rubies won't have kettle-soup-cover.
#       The rescue LoadError handles that scenario.
begin
  require "kettle-soup-cover"
  require "simplecov" if Kettle::Soup::Cover::DO_COV # `.simplecov` is run here!
rescue LoadError => error
  # check the error message, and re-raise if not what is expected
  raise error unless error.message.include?("kettle")
end

# This gem
require "oauth2"
