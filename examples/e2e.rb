# frozen_string_literal: true

# End-to-end example using oauth2 gem against a local mock-oauth2-server.
# Prerequisites:
#   1) Start the mock server (HTTP on 8080):
#        docker compose -f docker-compose-ssl.yml up -d --wait
#   2) Run this script:
#        ruby examples/e2e.rb
#   3) Stop the server when you're done:
#        docker compose -f docker-compose-ssl.yml down
# Notes:
#   - The mock server uses a self-signed certificate. SSL verification is disabled in this example.
#   - Tested down to Ruby 2.4 (avoid newer syntax).

require "oauth2"
require "json"
require "net/http"
require "uri"

module E2E
  class ClientCredentialsDemo
    attr_reader :client_id, :client_secret, :issuer_base, :realm

    # issuer_base: e.g., https://localhost:8080
    # realm: mock-oauth2-server issuer id ("default" by default)
    def initialize(client_id, client_secret, issuer_base, realm)
      @client_id = client_id
      @client_secret = client_secret
      @issuer_base = issuer_base
      @realm = realm
    end

    def run
      wait_for_server_ready
      well_known = discover
      token = fetch_token(well_known)
      puts "Access token (truncated): #{token.token[0, 20]}..."
      call_userinfo(well_known, token)
      puts "E2E complete"
    end

  private

    def discovery_url
      File.join(@issuer_base, @realm, "/.well-known/openid-configuration")
    end

    def wait_for_server_ready(timeout = nil)
      timeout = (timeout || ENV["E2E_WAIT_TIMEOUT"] || 90).to_i
      uri = URI(discovery_url)
      deadline = Time.now + timeout
      announced = false
      loop do
        begin
          http = Net::HTTP.new(uri.host, uri.port)
          http.use_ssl = uri.scheme == "https"
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
          req = Net::HTTP::Get.new(uri.request_uri)
          res = http.request(req)
          return if res.code.to_i == 200
        rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH, Errno::ECONNRESET, SocketError, EOFError, OpenSSL::SSL::SSLError
          # ignore and retry until timeout
        end
        unless announced
          puts "Waiting for mock OAuth2 server at #{uri} ..."
          announced = true
        end
        break if Time.now >= deadline
        sleep(0.5)
      end
      raise "Server not reachable at #{uri} within #{timeout}s. Ensure it's running: docker compose -f docker-compose-ssl.yml up -d --wait. You can increase the wait by setting E2E_WAIT_TIMEOUT (seconds)."
    end

    def discover
      uri = URI(discovery_url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == "https"
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      req = Net::HTTP::Get.new(uri.request_uri)
      res = http.request(req)
      unless res.code.to_i == 200
        raise "Discovery failed: #{res.code} #{res.message} - #{res.body}"
      end
      data = JSON.parse(res.body)
      # Expect token_endpoint and possibly userinfo_endpoint
      data
    end

    def fetch_token(well_known)
      client = OAuth2::Client.new(
        @client_id,
        @client_secret,
        site: @issuer_base,
        token_url: URI.parse(well_known["token_endpoint"]).request_uri,
        ssl: {verify: false},
        auth_scheme: :request_body, # send client creds in request body (compatible default for mock servers)
      )
      # Use client_credentials grant
      client.client_credentials.get_token
    end

    def call_userinfo(well_known, token)
      userinfo = well_known["userinfo_endpoint"]
      unless userinfo
        puts "No userinfo_endpoint advertised by server; skipping userinfo call."
        return
      end
      uri = URI(userinfo)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == "https"
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      req = Net::HTTP::Get.new(uri.request_uri)
      req["Authorization"] = "Bearer #{token.token}"
      res = http.request(req)
      puts "userinfo status: #{res.code} #{res.message}"
      if res.code.to_i == 200
        begin
          body = JSON.parse(res.body)
        rescue StandardError
          body = res.body
        end
        puts "userinfo body: #{body.inspect}"
      else
        puts "userinfo error body: #{res.body}"
      end
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  # These must match the mock server configuration (see config-ssl.json)
  client_id = ENV["E2E_CLIENT_ID"] || "demo-client"
  client_secret = ENV["E2E_CLIENT_SECRET"] || "demo-secret"
  issuer_base = ENV["E2E_ISSUER_BASE"] || "http://localhost:8080"
  realm = ENV["E2E_REALM"] || "default"

  E2E::ClientCredentialsDemo.new(client_id, client_secret, issuer_base, realm).run
end
