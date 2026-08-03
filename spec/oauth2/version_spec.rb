# frozen_string_literal: true

require "anonymous_loader"
require "oauth2"
RSpec.describe OAuth2::Version do
  it_behaves_like "a Version module", described_class

  it "is greater than 1.0.0" do
    expect(Gem::Version.new(described_class) >= Gem::Version.new("1.0.0")).to(be(true))
  end

  it "executes the version file for coverage without redefining constants" do
    paths = [
      File.expand_path("../../lib/oauth2/version.rb", __dir__),
      File.expand_path("../../lib/oauth2/version_gem.rb", __dir__),
    ].select { |path| File.file?(path) }
    anonymous_namespace = AnonymousLoader.load(files: paths)

    expect(anonymous_namespace::OAuth2::Version::VERSION).to eq(described_class::VERSION)
  end
end
