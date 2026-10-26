# frozen_string_literal: true

require "anonymous_loader"
RSpec.describe OAuth2::Version do
  it "executes the version file for coverage without redefining constants" do
    path = File.expand_path("../../lib/oauth2/version.rb", __dir__)
    anonymous_namespace = AnonymousLoader.load(:files => path)

    expect(anonymous_namespace::OAuth2::Version::VERSION).to eq(described_class::VERSION)
  end

  it "exposes semantic version components" do
    expect(described_class.major).to eq(1)
    expect(described_class.minor).to eq(4)
    expect(described_class.patch).to be >= 11
    expect(described_class.pre).to be_nil
    expect(described_class.to_h).to eq(
      :major => described_class.major,
      :minor => described_class.minor,
      :patch => described_class.patch,
      :pre => described_class.pre
    )
    expect(described_class.to_a).to eq([1, 4, described_class.patch])
    expect(described_class.to_s).to eq(described_class::VERSION)
  end
end
