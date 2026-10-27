# frozen_string_literal: true

RSpec.describe OAuth2::SanitizedLogFormatter do
  subject(:formatter) { described_class.new(logger: logger, options: {}) }

  let(:logger) { instance_double(Logger) }

  def dump(body, code_context: false)
    formatter.instance_variable_set(:@code_context, code_context)
    formatter.dump_body(body)
  end

  describe "#dump_body with Hash bodies" do
    it "redacts filtered keys at any depth" do
      rendered = dump({client: {client_secret: "shhh", name: "ok"}, grant_type: "refresh_token"})

      expect(rendered).not_to include("shhh")
      expect(rendered).to include("ok")
    end

    it "matches keys case-insensitively" do
      expect(dump({"Client_Secret" => "shhh"})).not_to include("shhh")
    end

    it "redacts the authorization code only in authorization_code context" do
      in_context = dump({"grant_type" => "authorization_code", "code" => "secret-code", "note" => "ok"})
      expect(in_context).not_to include("secret-code")
      expect(in_context).to include("ok")

      out_of_context = dump({"code" => "error-123", "note" => "ok"})
      expect(out_of_context).to include("error-123")
    end

    it "survives cyclic structures" do
      cyclic = {}
      cyclic[:self] = cyclic
      cyclic[:client_secret] = "shhh"

      rendered = dump(cyclic)
      expect(rendered).not_to include("shhh")
    end

    it "keeps nil values" do
      rendered = dump({"client_secret" => "shhh", "note" => nil})

      expect(rendered).not_to include("shhh")
      expect(rendered).to include("nil")
    end
  end

  describe "#dump_body with Array bodies" do
    it "redacts filtered keys in form-pair arrays" do
      rendered = dump([["grant_type", "authorization_code"], ["client_secret", "shhh"]])

      expect(rendered).not_to include("shhh")
      expect(rendered).to include("authorization_code")
    end

    it "redacts code in pair arrays within authorization_code context" do
      rendered = dump([["grant_type", "authorization_code"], ["code", "secret-code"]])
      expect(rendered).not_to include("secret-code")
    end

    it "redacts filtered keys in arrays of hashes" do
      rendered = dump([{"access_token" => "abc123"}])
      expect(rendered).not_to include("abc123")
    end

    it "survives cyclic arrays" do
      cyclic = [{"access_token" => "abc123"}]
      cyclic << cyclic

      rendered = dump(cyclic)
      expect(rendered).not_to include("abc123")
    end
  end

  describe "#dump_body with String bodies" do
    it "redacts code in form-encoded strings only in authorization_code context" do
      in_context = dump("grant_type=authorization_code&code=secret-code", code_context: true)
      expect(in_context).not_to include("secret-code")

      out_of_context = dump("code=error-123", code_context: false)
      expect(out_of_context).to include("error-123")
    end

    it "redacts code in JSON strings in authorization_code context" do
      rendered = dump('{"grant_type":"authorization_code","code":"secret-code"}', code_context: true)
      expect(rendered).not_to include("secret-code")
    end

    it "does not raise on invalid UTF-8" do
      body = +"grant_type=authorization_code&code=secret\xFF"
      body.force_encoding(Encoding::UTF_8)
      rendered = dump(body, code_context: true)
      expect(rendered).not_to include("secret")
    end

    it "redacts code in Hash#inspect-shaped strings in authorization_code context" do
      expect(dump('{"code" => "secret-code"}', code_context: true)).not_to include("secret-code")
      expect(dump('{"code"=>"secret-code"}', code_context: true)).not_to include("secret-code")
    end

    it "passes non-structured bodies through unchanged outside context" do
      expect(dump("plain text")).to include("plain text")
    end
  end

  describe "#dump_body with other bodies" do
    it "leaves rendering to Faraday" do
      expect(dump(42)).to eq(42.pretty_inspect)
    end
  end

  describe "logging requests and responses" do
    subject(:formatter) { described_class.new(logger: logger, options: {bodies: true}) }

    let(:log) { StringIO.new }
    let(:logger) { Logger.new(log) }

    it "redacts the code from a logged authorization_code request URL without changing the request" do
      url = URI.parse("https://x.test/token?grant_type=authorization_code&code=secret-code&scope=read+write")
      env = Faraday::Env.from(method: :get, url: url, request_headers: {})

      formatter.request(env)

      expect(log.string).not_to include("secret-code")
      expect(log.string).to include("code=[FILTERED]")
      expect(log.string).to include("grant_type=authorization_code")
      expect(env.url.query).to include("code=secret-code")
    end

    it "logs request URLs unchanged outside authorization_code context" do
      url = URI.parse("https://x.test/callback?code=error-123")
      env = Faraday::Env.from(method: :get, url: url, request_headers: {})

      formatter.request(env)

      expect(log.string).to include("code=error-123")
    end

    it "redacts the code from a response body in authorization_code context" do
      url = URI.parse("https://x.test/token?grant_type=authorization_code")
      env = Faraday::Env.from(method: :post, url: url, status: 200, response_headers: {}, body: '{"code":"secret-code"}')

      formatter.response(env)

      expect(log.string).not_to include("secret-code")
      expect(log.string).to include("Status 200")
    end

    it "restores the previous context after logging" do
      url = URI.parse("https://x.test/token?grant_type=authorization_code")
      env = Faraday::Env.from(method: :post, url: url, status: 200, response_headers: {}, body: "")

      formatter.response(env)

      expect(formatter.instance_variable_get(:@code_context)).to be(false)
    end
  end

  describe "authorization_code context detection" do
    def detected?(url:, body: nil)
      env = Faraday::Env.from(url: URI.parse(url), body: body)
      formatter.send(:authorization_code_request?, env)
    end

    it "detects from the URL query" do
      expect(detected?(url: "https://x.test/t?grant_type=authorization_code&code=abc")).to be(true)
    end

    it "detects from a form-encoded string body" do
      expect(detected?(url: "https://x.test/t", body: "grant_type=authorization_code&code=abc")).to be(true)
    end

    it "detects from a JSON string body with an escaped grant key" do
      expect(detected?(url: "https://x.test/t", body: '{"grant _type":"authorization_code","code":"abc"}'.gsub("grant _type", "grant_type"))).to be(true)
    end

    it "detects from a Hash body" do
      expect(detected?(url: "https://x.test/t", body: {grant_type: "authorization_code"})).to be(true)
    end

    it "detects from a pair-array body" do
      expect(detected?(url: "https://x.test/t", body: [["grant_type", "authorization_code"]])).to be(true)
    end

    it "detects from the body of an env without a URL" do
      env = Struct.new(:body).new("grant_type=authorization_code&code=abc")
      expect(formatter.send(:authorization_code_request?, env)).to be(true)
    end

    it "detects from the body when the URL is nil" do
      env = Faraday::Env.from(url: nil, body: {grant_type: "authorization_code"})
      expect(formatter.send(:authorization_code_request?, env)).to be(true)
    end

    it "does not trigger for an env without a body" do
      env = Struct.new(:url).new(URI.parse("https://x.test/t?grant_type=client_credentials"))
      expect(formatter.send(:authorization_code_request?, env)).to be(false)
    end

    it "does not trigger for other grants" do
      expect(detected?(url: "https://x.test/t?grant_type=client_credentials")).to be(false)
      expect(detected?(url: "https://x.test/t", body: {grant_type: "password"})).to be(false)
    end
  end
end
