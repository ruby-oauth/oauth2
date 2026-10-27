# frozen_string_literal: true

require_relative "duel_helper"

# The token endpoint, once per sign-in or refresh: building the request,
# authenticating the client, and turning the response into an AccessToken

duel "token: exchange an auth code" do
  once do
    @client = oauth_client
    @client.auth_code.get_token("SplxlOBeZQQYbYS6WxSbIA") # warms the stubs
  end
  @client.auth_code.get_token("SplxlOBeZQQYbYS6WxSbIA")
end

duel "token: exchange a code for an OIDC token" do
  once do
    @client = oauth_client(token_url: "/oidc/token")
    @client.auth_code.get_token("SplxlOBeZQQYbYS6WxSbIA")
  end
  @client.auth_code.get_token("SplxlOBeZQQYbYS6WxSbIA")
end

duel "token: client credentials in the body" do
  once do
    @client = oauth_client(auth_scheme: :request_body)
    @client.client_credentials.get_token(scope: "api.read")
  end
  @client.client_credentials.get_token(scope: "api.read")
end

duel "token: refresh an access token" do
  once do
    client = oauth_client
    @token = OAuth2::AccessToken.new(client, DUEL_ACCESS_TOKEN, refresh_token: DUEL_REFRESH_TOKEN, expires_in: 3600)
    @token.refresh
  end
  @token.refresh
end

duel "token: a JWT bearer assertion" do
  once do
    @client = oauth_client
    @claims = {
      iss: "s6BhdRkqt3",
      sub: "s6BhdRkqt3",
      aud: "#{DUEL_SITE}/oauth/token",
      iat: 1_767_225_600,
      exp: 1_767_229_200,
      jti: "id123456",
    }
    @encoding = {algorithm: "HS256", key: "a-shared-secret-of-at-least-32-bytes!", kid: "key-1"}
    @client.assertion.get_token(@claims, @encoding)
  end
  @client.assertion.get_token(@claims, @encoding)
end

duel "token: revoke an access token" do
  once do
    client = oauth_client
    @token = OAuth2::AccessToken.new(client, DUEL_ACCESS_TOKEN, refresh_token: DUEL_REFRESH_TOKEN)
    @token.revoke
  end
  @token.revoke
end
