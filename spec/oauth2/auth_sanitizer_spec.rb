# frozen_string_literal: true

RSpec.describe OAuth2::AUTH_SANITIZER do
  it "keeps auth-sanitizer constants isolated inside the OAuth2 namespace" do
    expect(Object.const_defined?(:Auth, false)).to be(false)
    expect(Object.const_defined?(:AuthSanitizer, false)).to be(false)
  end

  it "preserves the public OAuth2::FilteredAttributes alias" do
    expect(OAuth2::FilteredAttributes).to be(described_class::FilteredAttributes)
  end
end
