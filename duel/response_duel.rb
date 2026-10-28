# frozen_string_literal: true

require_relative "duel_helper"

# Response#parsed: picking a parser from the content type, parsing the
# body, and converting a Hash to a SnakyHash. Each iteration wraps the
# same Faraday response in a new Response, since parsed is memoized.

duel "response: parse a JSON token body" do
  once { @raw = faraday_response(token_body, json_headers) }
  OAuth2::Response.new(@raw).parsed
end

duel "response: parse a large JSON body" do
  once { @raw = faraday_response(resource_body(100), json_headers) }
  OAuth2::Response.new(@raw).parsed
end

duel "response: parse a form-encoded token body" do
  once do
    body = "access_token=#{DUEL_ACCESS_TOKEN}&token_type=bearer&expires_in=3600&refresh_token=#{DUEL_REFRESH_TOKEN}&scope=read+write"
    @raw = faraday_response(body, {"Content-Type" => "application/x-www-form-urlencoded"})
  end
  OAuth2::Response.new(@raw).parsed
end

duel "response: parse an XML token body" do
  once do
    body = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><response><access_token>#{DUEL_ACCESS_TOKEN}</access_token>" \
      "<token_type>bearer</token_type><expires_in>3600</expires_in><refresh_token>#{DUEL_REFRESH_TOKEN}</refresh_token></response>"
    @raw = faraday_response(body, {"Content-Type" => "application/xml"})
  end
  OAuth2::Response.new(@raw).parsed
end

duel "error: build from an error response" do
  once do
    body = JSON.generate("error" => "invalid_grant", "error_description" => "The authorization code has expired")
    @raw = Faraday::Response.new(status: 400, response_headers: json_headers, body: body)
  end
  OAuth2::Error.new(OAuth2::Response.new(@raw))
end
