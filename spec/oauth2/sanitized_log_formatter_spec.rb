if defined?(OAuth2::SanitizedLogFormatter)
  RSpec.describe OAuth2::SanitizedLogFormatter do
    subject(:formatter) do
      described_class.new(:logger => Logger.new($stdout), :options => {:bodies => true})
    end

    it "redacts sensitive values in nested hashes and arrays" do
      rendered = formatter.dump_body(
        "client_secret" => "client-secret-value",
        "nested" => [{"refresh_token" => "refresh-token-value"}]
      )

      expect(rendered).not_to include("client-secret-value", "refresh-token-value")
    end

    it "redacts sensitive values in form-pair arrays" do
      rendered = formatter.dump_body([
        ["grant_type", "refresh_token"],
        ["access_token", "array-token-value"],
      ])

      expect(rendered).not_to include("array-token-value")
    end

    it "redacts quoted secrets in serialized request and response bodies" do
      rendered = formatter.dump_body('{"client_secret":"quoted\\"secret-value"}')

      expect(rendered).not_to include("quoted", "secret-value")
    end

    it "redacts secrets in URL query strings" do
      sanitized = formatter.send(:sanitize_query, "grant_type=refresh_token&refresh_token=query-token-value")

      expect(sanitized).not_to include("query-token-value")
    end
  end
end
