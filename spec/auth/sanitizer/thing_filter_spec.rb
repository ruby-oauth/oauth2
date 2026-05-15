# frozen_string_literal: true

RSpec.describe Auth::Sanitizer::ThingFilter do
  describe "#initialize" do
    it "does not freeze caller-owned string inputs" do
      things = [String.new("secret")]
      label = String.new("[FILTERED]")

      described_class.new(things, label: label)

      expect(things.first).not_to be_frozen
      expect(label).not_to be_frozen
    end

    it "does not track later in-place mutation of original string inputs" do
      original_thing = String.new("secret")
      original_label = String.new("[FILTERED]")

      filter = described_class.new([original_thing], label: original_label)

      original_thing.replace("token")
      original_label.replace("[REDACTED]")

      expect(filter.filtered?("@secret")).to be(true)
      expect(filter.filtered?("@token")).to be(false)
      expect(filter.label).to eq("[FILTERED]")
    end
  end

  describe "FilteredAttributes integration" do
    let(:poro_class) do
      Class.new do
        include Auth::Sanitizer::FilteredAttributes

        attr_reader :secret, :name
        filtered_attributes :secret

        def initialize(secret, name)
          @secret = secret
          @name = name
        end
      end
    end

    let(:instance) { poro_class.new("super-secret", "bolt") }

    it "filters configured attributes in inspect" do
      expect(instance.inspect).to include("@secret=[FILTERED]")
      expect(instance.inspect).to include('@name="bolt"')
    end

    it "can be duplicated" do
      copy = instance.dup

      expect(copy).not_to equal(instance)
      expect(copy.inspect).to include("@secret=[FILTERED]")
      expect(copy.inspect).to include('@name="bolt"')
    end

    it "can be cloned" do
      copy = instance.clone

      expect(copy).not_to equal(instance)
      expect(copy.inspect).to include("@secret=[FILTERED]")
      expect(copy.inspect).to include('@name="bolt"')
    end
  end
end
