# frozen_string_literal: true

# Shared setup for the benchmarks in duel/. Every request goes to
# Faraday's in-process test adapter, so no benchmark waits on a socket
# and every iteration sees the same responses.

require "json"
require "faraday"
require "multi_xml"

# Pin the process-wide choices that would otherwise depend on what an
# earlier benchmark (or the bundle) happened to load: the XML backend
# that MultiXml picks, and the adapter that Faraday defaults to.
(defined?(MultiXML) ? MultiXML : MultiXml).parser = :rexml
Faraday.default_adapter = :test

DUEL_SITE = "https://auth.example.com"
DUEL_REDIRECT_URI = "https://app.example.com/oauth/callback"
DUEL_ACCESS_TOKEN = "eyJhY2Nlc3MiOiJ0b2tlbiJ9.c3RhYmxlLWFjY2Vzcy10b2tlbi1mb3ItYmVuY2htYXJrcw"
DUEL_REFRESH_TOKEN = "def50200a1b2c3d4e5f60718293a4b5c6d7e8f9012345678"

# A typical token endpoint response (RFC 6749, section 5.1)
def token_body
  JSON.generate(
    "access_token" => DUEL_ACCESS_TOKEN,
    "token_type" => "Bearer",
    "expires_in" => 3600,
    "refresh_token" => DUEL_REFRESH_TOKEN,
    "scope" => "openid profile email"
  )
end

# An OpenID Connect token response, with an ID token and the extra
# fields that providers add
def oidc_token_body
  JSON.generate(
    "access_token" => DUEL_ACCESS_TOKEN,
    "token_type" => "Bearer",
    "expires_in" => 3600,
    "refresh_token" => DUEL_REFRESH_TOKEN,
    "scope" => "openid profile email offline_access https://api.example.com/read https://api.example.com/write",
    "id_token" => "eyJhbGciOiJSUzI1NiIsImtpZCI6IjEyMyJ9.#{"eyJzdWIiOiIxMjM0NTY3ODkwIn0" * 24}.#{"c2lnbmF0dXJl" * 28}",
    "ext_expires_in" => 3600,
    "refresh_token_expires_in" => 86_400,
    "not-before-policy" => 0,
    "session_state" => "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
    "userId" => "1234567890",
    "accountType" => "personal"
  )
end

# A resource that an API returns to an access token: a page of records
def resource_body(records)
  JSON.generate(
    "total" => records,
    "nextPage" => nil,
    "items" => Array.new(records) do |i|
      {
        "id" => i,
        "displayName" => "User #{i}",
        "emailAddress" => "user#{i}@example.com",
        "createdAt" => "2026-01-01T00:00:00Z",
        "isActive" => i.even?,
        "roleNames" => %w[reader writer],
      }
    end
  )
end

def json_headers
  {"Content-Type" => "application/json; charset=utf-8"}
end

# Stubs for every endpoint that the benchmarks call
def endpoint_stubs
  Faraday::Adapter::Test::Stubs.new do |stub|
    stub.post("/oauth/token") { [200, json_headers, token_body] }
    stub.post("/oidc/token") { [200, json_headers, oidc_token_body] }
    stub.post("/oauth/revoke") { [200, json_headers, ""] }
    stub.get("/api/me") { [200, json_headers, resource_body(1)] }
    stub.get("/old/me") { [302, {"Location" => "/api/me"}, ""] }
  end
end

# A client like the ones apps build once and keep, wired to the stubs
def oauth_client(**options)
  stubs = endpoint_stubs
  OAuth2::Client.new(
    "s6BhdRkqt3",
    "7Fjfp0ZBr1KtDRbnfVdmIw",
    {site: DUEL_SITE, redirect_uri: DUEL_REDIRECT_URI}.merge(options)
  ) do |builder|
    builder.request(:url_encoded)
    builder.adapter(:test, stubs)
  end
end

# A raw Faraday response, as the client's connection returns it
def faraday_response(body, headers)
  Faraday::Response.new(status: 200, response_headers: headers, body: body)
end
