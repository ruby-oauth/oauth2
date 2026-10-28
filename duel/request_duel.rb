# frozen_string_literal: true

require_relative "duel_helper"

# What an app does with its token on every API call: sign the request,
# send it through the client, and parse the response

duel "request: GET a resource with a bearer token" do
  once do
    @token = OAuth2::AccessToken.new(oauth_client, DUEL_ACCESS_TOKEN)
    @token.get("/api/me").parsed
  end
  @token.get("/api/me").parsed
end

duel "request: GET a resource with a query token" do
  once do
    @token = OAuth2::AccessToken.new(oauth_client, DUEL_ACCESS_TOKEN, mode: :query)
    @token.get("/api/me").parsed
  end
  @token.get("/api/me").parsed
end

duel "request: follow a redirect" do
  once do
    @token = OAuth2::AccessToken.new(oauth_client, DUEL_ACCESS_TOKEN)
    @token.get("/old/me")
  end
  @token.get("/old/me")
end
