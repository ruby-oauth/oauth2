# frozen_string_literal: true

module OAuth2
  # Permanent alias for {OAuth2::AUTH_SANITIZER::FilteredAttributes}.
  #
  # This constant is intentionally kept in the `OAuth2` namespace because it
  # was part of the public API before the implementation was extracted into the
  # `auth-sanitizer` gem.  It will **not** be deprecated or removed.
  FilteredAttributes = OAuth2::AUTH_SANITIZER::FilteredAttributes
end
