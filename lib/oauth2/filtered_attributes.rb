# frozen_string_literal: true

module OAuth2
  # Permanent alias for {Auth::Sanitizer::FilteredAttributes}.
  #
  # This constant is intentionally kept in the `OAuth2` namespace because it
  # was part of the public API before the implementation was extracted into the
  # `auth-sanitizer` gem.  It will **not** be deprecated or removed.
  #
  # New code that does not need the `OAuth2::` namespace can use
  # {Auth::Sanitizer::FilteredAttributes} directly.
  FilteredAttributes = Auth::Sanitizer::FilteredAttributes
end
