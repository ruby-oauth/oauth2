# frozen_string_literal: true

module Oauth2
  module Version
    VERSION = "2.0.20"
  end
  VERSION = Version::VERSION # Traditional Constant Location
end

# kettle-jem:freeze
module OAuth2
  Version = Oauth2::Version unless const_defined?(:Version, false)
  VERSION = Version::VERSION unless const_defined?(:VERSION, false)
end
# kettle-jem:unfreeze
