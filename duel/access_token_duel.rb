# frozen_string_literal: true

require_relative "duel_helper"

# AccessToken on its own: apps rebuild tokens from stored hashes, and
# store them again, far more often than they fetch new ones

duel "access_token: build from a token hash" do
  once do
    @client = oauth_client
    @hash = JSON.parse(token_body)
  end
  OAuth2::AccessToken.from_hash(@client, @hash)
end

duel "access_token: build from a large token hash" do
  once do
    @client = oauth_client
    @hash = JSON.parse(oidc_token_body)
    40.times { |i| @hash["custom_claim_#{i}"] = "value #{i}" }
  end
  OAuth2::AccessToken.from_hash(@client, @hash)
end

duel "access_token: serialize with to_hash" do
  once do
    hash = JSON.parse(oidc_token_body).merge("expires_at" => 1_767_229_200)
    hash.delete("expires_in")
    @token = OAuth2::AccessToken.from_hash(oauth_client, hash)
  end
  @token.to_hash
end
