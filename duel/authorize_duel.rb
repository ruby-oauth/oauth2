# frozen_string_literal: true

require_relative "duel_helper"

# The URL that an app redirects each user to, built once per sign-in
duel "authorize: a URL with the usual params" do
  once { @client = oauth_client }
  @client.auth_code.authorize_url(
    scope: "openid profile email",
    state: "af0ifjsldkj",
    code_challenge: "E9Melhoa2OwvFrEMTJguCHaoeK1t8URWbuGJSstw-cM",
    code_challenge_method: "S256"
  )
end

duel "authorize: a URL with many params" do
  once do
    @client = oauth_client
    @params = {
      scope: "openid profile email address phone offline_access https://api.example.com/read https://api.example.com/write",
      state: "af0ifjsldkj",
      nonce: "n-0S6_WzA2Mj",
      code_challenge: "E9Melhoa2OwvFrEMTJguCHaoeK1t8URWbuGJSstw-cM",
      code_challenge_method: "S256",
      prompt: "consent select_account",
      max_age: 3600,
      ui_locales: "en-US fr-CA",
      login_hint: "user@example.com",
      acr_values: "urn:mace:incommon:iap:silver",
      response_mode: "query",
      display: "page",
      access_type: "offline",
      include_granted_scopes: true,
      claims: JSON.generate("userinfo" => {"email" => {"essential" => true}, "email_verified" => nil}),
      audience: "https://api.example.com",
    }
  end
  @client.auth_code.authorize_url(@params)
end
