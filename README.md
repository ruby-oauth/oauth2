<a href="https://github.com/ruby-oauth"><img alt="ruby-oauth Logo by Aboling0, CC BY-SA 4.0" src="https://logos.galtzo.com/assets/images/ruby-oauth/avatar-128px.svg" width="14%" align="right"/></a>

# 🔐 OAuth2

[![Version][👽versioni]][👽version] [![GitHub tag (latest SemVer)][⛳️tag-img]][⛳️tag] [![License: MIT][📄license-img]][📄license] [![Downloads Rank][👽dl-ranki]][👽dl-rank] [![CodeCov Test Coverage][🏀codecovi]][🏀codecov] [![Coveralls Test Coverage][🏀coveralls-img]][🏀coveralls] [![QLTY Test Coverage][🏀qlty-covi]][🏀qlty-cov] [![QLTY Maintainability][🏀qlty-mnti]][🏀qlty-mnt] [![CI Heads][🚎3-hd-wfi]][🚎3-hd-wf] [![CI Runtime Dependencies @ HEAD][🚎12-crh-wfi]][🚎12-crh-wf] [![CI Current][🚎11-c-wfi]][🚎11-c-wf] [![CI Truffle Ruby][🚎9-t-wfi]][🚎9-t-wf] [![CI JRuby][🚎10-j-wfi]][🚎10-j-wf] [![Deps Locked][🚎13-🔒️-wfi]][🚎13-🔒️-wf] [![Deps Unlocked][🚎14-🔓️-wfi]][🚎14-🔓️-wf] [![CI Test Coverage][🚎2-cov-wfi]][🚎2-cov-wf] [![CI Style][🚎5-st-wfi]][🚎5-st-wf] [![Apache SkyWalking Eyes License Compatibility Check][🚎15-🪪-wfi]][🚎15-🪪-wf]

`if ci_badges.map(&:color).detect { it != "green"}` ☝️ [let me know][✉️discord-invite], as I may have missed the [discord notification][✉️discord-invite].

---

`if ci_badges.map(&:color).all? { it == "green"}` 👇️ send money so I can do more of this. FLOSS maintenance is now my full-time job.

[![OpenCollective Backers][🖇osc-backers-i]][🖇osc-backers] [![OpenCollective Sponsors][🖇osc-sponsors-i]][🖇osc-sponsors] [![Sponsor Me on Github][🖇sponsor-img]][🖇sponsor] [![Liberapay Goal Progress][⛳liberapay-img]][⛳liberapay] [![Donate on PayPal][🖇paypal-img]][🖇paypal] [![Buy me a coffee][🖇buyme-small-img]][🖇buyme] [![Donate on Polar][🖇polar-img]][🖇polar] [![Donate at ko-fi.com][🖇kofi-img]][🖇kofi]

<details>
 <summary>👣 How will this project approach the September 2025 hostile takeover of RubyGems? 🚑️</summary>

I've summarized my thoughts in [this blog post](https://dev.to/galtzo/hostile-takeover-of-rubygems-my-thoughts-5hlo).

</details>

## 🌻 Synopsis <a href="https://discord.gg/3qme4XHNKN"><img alt="Galtzo FLOSS Logo by Aboling0, CC BY-SA 4.0" src="https://logos.galtzo.com/assets/images/galtzo-floss/avatar-128px.svg" width="8%" align="right"/></a> <a href="https://ruby-toolbox.com"><img alt="ruby-lang Logo, Yukihiro Matsumoto, Ruby Visual Identity Team, CC BY-SA 2.5" src="https://logos.galtzo.com/assets/images/ruby-lang/avatar-128px.svg" width="8%" align="right"/></a>

OAuth 2.0 is the industry-standard protocol for authorization.
This is a RubyGem for implementing OAuth 2.0 clients (not servers) in Ruby applications.

⭐️ including OAuth 2.1 draft spec & OpenID Connect (OIDC)

### Quick Examples

<details markdown="1">
  <summary>Convert the following `curl` command into a token request using this gem...</summary>

```shell
curl --request POST \
  --url 'https://login.microsoftonline.com/REDMOND_REDACTED/oauth2/token' \
  --header 'content-type: application/x-www-form-urlencoded' \
  --data grant_type=client_credentials \
  --data client_id=REDMOND_CLIENT_ID \
  --data client_secret=REDMOND_CLIENT_SECRET \
  --data resource=REDMOND_RESOURCE_UUID
```

NOTE: In the ruby version below, certain params are passed to the `get_token` call, instead of the client creation.

```ruby
client = OAuth2::Client.new(
  "REDMOND_CLIENT_ID", # client_id
  "REDMOND_CLIENT_SECRET", # client_secret
  auth_scheme: :request_body, # Other modes are supported: :basic_auth, :tls_client_auth, :private_key_jwt
  token_url: "oauth2/token", # relative path, except with leading `/`, then absolute path
  site: "https://login.microsoftonline.com/REDMOND_REDACTED"
)
client.
  client_credentials. # There are many other types to choose from!
  get_token(resource: "REDMOND_RESOURCE_UUID")
```

NOTE: `header` - The content type specified in the `curl` is already the default!

</details>

<details markdown="1">
<summary>Complete E2E single file script against mock-oauth2-server</summary>

- E2E example uses [navikt/mock-oauth2-server](https://github.com/navikt/mock-oauth2-server), which was added in v2.0.11
- E2E example does not ship with the released gem, so clone the source to play with it.

```console
docker compose -f docker-compose-ssl.yml up -d --wait
ruby examples/e2e.rb
# If your machine is slow or Docker pulls are cold, increase the wait:
E2E_WAIT_TIMEOUT=120 ruby examples/e2e.rb
# The mock server serves HTTP on 8080; the example points to http://localhost:8080 by default.
```

The output should be something like this:

```console
➜  ruby examples/e2e.rb
Access token (truncated): eyJraWQiOiJkZWZhdWx0...
userinfo status: 200
userinfo body: {"sub" => "demo-sub", "aud" => ["demo-aud"], "nbf" => 1757816758000, "iss" => "http://localhost:8080/default", "exp" => 1757820358000, "iat" => 1757816758000, "jti" => "d63b97a7-ebe5-4dea-93e6-d542caba6104"}
E2E complete
```

Make sure to shut down the mock server when you are done:

```console
docker compose -f docker-compose-ssl.yml down
```

Troubleshooting: validate connectivity to the mock server

- Check container status and port mapping:
    - `docker compose -f docker-compose-ssl.yml ps`
- From the host, try the discovery URL directly (this is what the example uses by default):
    - `curl -v http://localhost:8080/default/.well-known/openid-configuration`
    - If that fails immediately, also try: `curl -v --connect-timeout 2 http://127.0.0.1:8080/default/.well-known/openid-configuration`
- From inside the container (to distinguish container vs. host networking):
    - `docker exec -it oauth2-mock-oauth2-server-1 curl -v http://127.0.0.1:8080/default/.well-known/openid-configuration`
- Simple TCP probe from the host:
    - `nc -vz localhost 8080  # or: ruby -rsocket -e 'TCPSocket.new("localhost",8080).close; puts "tcp ok"'`
- Inspect which host port 8080 is bound to (should be 8080):
    - `docker inspect -f '{{ (index (index .NetworkSettings.Ports "8080/tcp") 0).HostPort }}' oauth2-mock-oauth2-server-1`
- Look at server logs for readiness/errors:
    - `docker logs -n 200 oauth2-mock-oauth2-server-1`
- On Linux, ensure nothing else is bound to 8080 and that firewall/SELinux aren’t blocking:
    - `ss -ltnp | grep :8080`

Notes

- Discovery URL pattern is: `http://localhost:8080/<realm>/.well-known/openid-configuration`, where `<realm>` defaults to `default`.
- You can change these with env vars when running the example:
    - `E2E_ISSUER_BASE` (default: http://localhost:8080)
    - `E2E_REALM` (default: default)

</details>

### Alternatives

This gem is a low-level OAuth 2.0 **client** (it talks _to_ an authorization server to obtain and use tokens).
If that isn't quite what you need, one of the following libraries may be a better fit (the first row is this gem for comparison):

| Library                                                           | Role                                     | When to use it                                                                                                                                                                                                       |
|-------------------------------------------------------------------|------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **this gem** ([oauth2][📜src-gh])                                 | OAuth 2.0 / 2.1 + OIDC **client**        | You are calling an OAuth 2.0 API, or signing in against a provider, and want a small, dependency-light, spec-faithful client with fine-grained control over the request/response cycle.                              |
| [oauth2-mcp][sibling-mcp-gem]                                     | OAuth 2.1 MCP Auth client **and** server | Focused, spec-faithful, MCP Auth client with fine-grained control over the request/response cycle. Rack/Roda compatible clients and servers. Built on top of this gem, [oauth2][📜src-gh].                           |
| [omniauth][omniauth-gem] + [omniauth-oauth2][omniauth-oauth2-gem] | "Log in with…" **client** (Rack)         | You primarily want user _authentication_ ("Log in with GitHub/GitLab/Google") wired into a Rack/Rails app via a strategy, rather than driving the token flow yourself. Built on top of this gem, [oauth2][📜src-gh]. |
| [openid_connect][openid-connect-gem]                              | OpenID Connect client & server           | You need full [OpenID Connect][oidc-spec] (ID-token validation, discovery, userinfo, etc.) with batteries included. Maintained by [@nov][nov].                                                                       |
| [rack-oauth2][rack-oauth2-gem]                                    | OAuth 2.0 client **and** server          | You want lower-level Rack primitives, need both client and server pieces, or are building on top of `openid_connect`. Maintained by [@nov][nov].                                                                     |
| [doorkeeper][doorkeeper-gem]                                      | OAuth 2.0 **server / provider**          | You want to _be_ the authorization server — issuing tokens to other apps — in a Rails/Grape/Sinatra application, rather than acting as a client.                                                                     |
| [oauth][sibling-gem]                                              | OAuth **1.0a** client & server           | The provider you integrate with only speaks the older OAuth 1.0a protocol. This is our sibling gem.                                                                                                                  |

See also the [OAuth 2.0 Spec][oauth2-spec], the [OpenID Connect Spec][oidc-spec], and the [MCP Auth Spec][mcp-auth-spec].

[oauth2-spec]: https://oauth.net/2/
[oidc-spec]: https://openid.net/specs/openid-connect-core-1_0.html
[mcp-auth-spec]: https://modelcontextprotocol.io/specification/draft/basic/authorization
[sibling-gem]: https://gitlab.com/ruby-oauth/oauth
[sibling-mcp-gem]: https://github.com/ruby-oauth/oauth2-mcp
[doorkeeper-gem]: https://github.com/doorkeeper-gem/doorkeeper
[omniauth-gem]: https://github.com/omniauth/omniauth
[omniauth-oauth2-gem]: https://github.com/omniauth/omniauth-oauth2
[openid-connect-gem]: https://github.com/nov/openid_connect
[rack-oauth2-gem]: https://github.com/nov/rack-oauth2
[nov]: https://github.com/nov

## 💡 Info you can shake a stick at

| Tokens to Remember | [![Gem name][⛳️name-img]][⛳️gem-name] [![Gem namespace][⛳️namespace-img]][⛳️gem-namespace] |
|-------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Works with JRuby | [![JRuby 9.2 Compat][💎jruby-9.2i]][🚎jruby-9.2-wf] [![JRuby 9.3 Compat][💎jruby-9.3i]][🚎jruby-9.3-wf] <br/> [![JRuby 9.4 Compat][💎jruby-9.4i]][🚎jruby-9.4-wf] [![JRuby current Compat][💎jruby-c-i]][🚎10-j-wf] [![JRuby HEAD Compat][💎jruby-headi]][🚎3-hd-wf]|
| Works with Truffle Ruby | [![Truffle Ruby 22.3 Compat][💎truby-22.3i]][🚎truby-22.3-wf] [![Truffle Ruby 23.0 Compat][💎truby-23.0i]][🚎truby-23.0-wf] [![Truffle Ruby 23.1 Compat][💎truby-23.1i]][🚎truby-23.1-wf] <br/> [![Truffle Ruby 24.2 Compat][💎truby-24.2i]][🚎truby-24.2-wf] [![Truffle Ruby 25.0 Compat][💎truby-25.0i]][🚎truby-25.0-wf] [![Truffle Ruby current Compat][💎truby-c-i]][🚎9-t-wf]|
| Works with MRI Ruby 4 | [![Ruby 4.0 Compat][💎ruby-4.0i]][🚎11-c-wf] [![Ruby current Compat][💎ruby-c-i]][🚎11-c-wf] [![Ruby HEAD Compat][💎ruby-headi]][🚎3-hd-wf]|
| Works with MRI Ruby 3 | [![Ruby 3.0 Compat][💎ruby-3.0i]][🚎ruby-3.0-wf] [![Ruby 3.1 Compat][💎ruby-3.1i]][🚎ruby-3.1-wf] [![Ruby 3.2 Compat][💎ruby-3.2i]][🚎ruby-3.2-wf] [![Ruby 3.3 Compat][💎ruby-3.3i]][🚎ruby-3.3-wf] [![Ruby 3.4 Compat][💎ruby-3.4i]][🚎ruby-3.4-wf]|
| Works with MRI Ruby 2 | ![Ruby 2.2 Compat][💎ruby-2.2i] ![Ruby 2.3 Compat][💎ruby-2.3i] <br/> [![Ruby 2.4 Compat][💎ruby-2.4i]][🚎ruby-2.4-wf] [![Ruby 2.5 Compat][💎ruby-2.5i]][🚎ruby-2.5-wf] [![Ruby 2.6 Compat][💎ruby-2.6i]][🚎ruby-2.6-wf] [![Ruby 2.7 Compat][💎ruby-2.7i]][🚎ruby-2.7-wf]|
| Support & Community | [![Join Me on Daily.dev's RubyFriends][✉️ruby-friends-img]][✉️ruby-friends] [![Live Chat on Discord][✉️discord-invite-img-ftb]][✉️discord-invite] [![Get help from me on Upwork][👨🏼‍🏫expsup-upwork-img]][👨🏼‍🏫expsup-upwork] [![Get help from me on Codementor][👨🏼‍🏫expsup-codementor-img]][👨🏼‍🏫expsup-codementor] |
| Source | [![Source on GitLab.com][📜src-gl-img]][📜src-gl] [![Source on CodeBerg.org][📜src-cb-img]][📜src-cb] [![Source on Github.com][📜src-gh-img]][📜src-gh] [![The best SHA: dQw4w9WgXcQ!][🧮kloc-img]][🧮kloc] |
| Documentation | [![Current release on RubyDoc.info][📜docs-cr-rd-img]][🚎yard-current] [![YARD on Galtzo.com][📜docs-head-rd-img]][🚎yard-head] [![Maintainer Blog][🚂maint-blog-img]][🚂maint-blog] [![GitLab Wiki][📜gl-wiki-img]][📜gl-wiki] [![GitHub Wiki][📜gh-wiki-img]][📜gh-wiki] |
| Compliance | [![License: MIT][📄license-img]][📄license] [![Apache license compatibility: Category A][📄license-compat-img]][📄license-compat] [![📄ilo-declaration-img]][📄ilo-declaration] [![Security Policy][🔐security-img]][🔐security] [![Contributor Covenant 2.1][🪇conduct-img]][🪇conduct] [![SemVer 2.0.0][📌semver-img]][📌semver] |
| Style | [![Enforced Code Style Linter][💎rlts-img]][💎rlts] [![Keep-A-Changelog 1.0.0][📗keep-changelog-img]][📗keep-changelog] [![Gitmoji Commits][📌gitmoji-img]][📌gitmoji] [![Compatibility appraised by: appraisal2][💎appraisal2-img]][💎appraisal2] |
| Maintainer 🎖️ | [![Follow Me on LinkedIn][💖🖇linkedin-img]][💖🖇linkedin] [![Follow Me on Ruby.Social][💖🐘ruby-mast-img]][💖🐘ruby-mast] [![Follow Me on Bluesky][💖🦋bluesky-img]][💖🦋bluesky] [![Contact Maintainer][🚂maint-contact-img]][🚂maint-contact] [![My technical writing][💖💁🏼‍♂️devto-img]][💖💁🏼‍♂️devto] |
| `...` 💖 | [![Find Me on WellFound:][💖✌️wellfound-img]][💖✌️wellfound] [![Find Me on CrunchBase][💖💲crunchbase-img]][💖💲crunchbase] [![My LinkTree][💖🌳linktree-img]][💖🌳linktree] [![More About Me][💖💁🏼‍♂️aboutme-img]][💖💁🏼‍♂️aboutme] [🧊][💖🧊berg] [🐙][💖🐙hub] [🛖][💖🛖hut] [🧪][💖🧪lab] |

### Compatibility

Compatible with MRI Ruby 2.2.0+, and concordant releases of JRuby, and TruffleRuby.
CI workflows and Appraisals are generated for MRI Ruby 2.4+.
This test floor is configured by `ruby.test_minimum` in `.kettle-jem.yml` and
may be higher than the gem's runtime compatibility floor when legacy Rubies are
not practical for the current toolchain.

| 🚚 _Amazing_ test matrix was brought to you by | 🔎 appraisal2 🔎 and the color 💚 green 💚 |
|------------------------------------------------|--------------------------------------------------------|
| 👟 Check it out! | ✨ [github.com/appraisal-rb/appraisal2][💎appraisal2] ✨ |

### Federated DVCS

<details markdown="1">
 <summary>Find this repo on federated forges (Coming soon!)</summary>

| Federated [DVCS][💎d-in-dvcs] Repository | Status | Issues | PRs | Wiki | CI | Discussions |
|-------------------------------------------------|-----------------------------------------------------------------------|---------------------------|--------------------------|---------------------------|--------------------------|------------------------------|
| 🧪 [ruby-oauth/oauth2 on GitLab][📜src-gl] | The Truth | [💚][🤝gl-issues] | [💚][🤝gl-pulls] | [💚][📜gl-wiki] | 🐭 Tiny Matrix | ➖ |
| 🧊 [ruby-oauth/oauth2 on CodeBerg][📜src-cb] | An Ethical Mirror ([Donate][🤝cb-donate]) | [💚][🤝cb-issues] | [💚][🤝cb-pulls] | ➖ | ⭕️ No Matrix | ➖ |
| 🐙 [ruby-oauth/oauth2 on GitHub][📜src-gh] | Another Mirror | [💚][🤝gh-issues] | [💚][🤝gh-pulls] | [💚][📜gh-wiki] | 💯 Full Matrix | [💚][gh-discussions] |
| 🎮️ [Discord Server][✉️discord-invite] | [![Live Chat on Discord][✉️discord-invite-img-ftb]][✉️discord-invite] | [Let's][✉️discord-invite] | [talk][✉️discord-invite] | [about][✉️discord-invite] | [this][✉️discord-invite] | [library!][✉️discord-invite] |

</details>

[gh-discussions]: https://github.com/ruby-oauth/oauth2/discussions

### Enterprise Support [![Tidelift](https://tidelift.com/badges/package/rubygems/oauth2)](https://tidelift.com/subscription/pkg/rubygems-oauth2?utm_source=rubygems-oauth2&utm_medium=referral&utm_campaign=readme)

Available as part of the Tidelift Subscription.

<details markdown="1">
 <summary>Need enterprise-level guarantees?</summary>

The maintainers of this and thousands of other packages are working with Tidelift to deliver commercial support and maintenance for the open source packages you use to build your applications. Save time, reduce risk, and improve code health, while paying the maintainers of the exact packages you use.

[![Get help from me on Tidelift][🏙️entsup-tidelift-img]][🏙️entsup-tidelift]

- 💡Subscribe for support guarantees covering _all_ your FLOSS dependencies
- 💡Tidelift is part of [Sonar][🏙️entsup-tidelift-sonar]
- 💡Tidelift pays maintainers to maintain the software you depend on!<br/>📊`@`Pointy Haired Boss: An [enterprise support][🏙️entsup-tidelift] subscription is "[never gonna let you down][🧮kloc]", and *supports* open source maintainers

Alternatively:

- [![Live Chat on Discord][✉️discord-invite-img-ftb]][✉️discord-invite]
- [![Get help from me on Upwork][👨🏼‍🏫expsup-upwork-img]][👨🏼‍🏫expsup-upwork]
- [![Get help from me on Codementor][👨🏼‍🏫expsup-codementor-img]][👨🏼‍🏫expsup-codementor]

</details>

## ✨ Installation

Install the gem and add to the application's Gemfile by executing:

```console
bundle add oauth2
```

If bundler is not being used to manage dependencies, install the gem by executing:

```console
gem install oauth2
```

## ⚙️ Configuration

Global settings for the library:

```ruby
OAuth2.configure do |config|
  config.silence_extra_tokens_warning = false # default: true
  config.silence_no_tokens_warning = false    # default: true
end
```

Filtering-related settings:

```ruby
OAuth2.configure do |config|
  config.filtered_label = "[REDACTED]" # default: "[FILTERED]"
  config.filtered_debug_keys += ["client_assertion"]
end
```

- `filtered_label` controls the placeholder used when sensitive values are filtered from inspected objects and debug logging output.
- `filtered_debug_keys` controls which key names have their values redacted from debug logging output when `OAUTH_DEBUG=true`.
- Debug logging remains opt-in and should still be used cautiously in production environments.

## 🔧 Basic Usage

### Client Initialization Options

`OAuth2::Client.new` accepts several options:

- `:site`: The base URL for the OAuth 2.0 provider.
- `:authorize_url`: The authorization endpoint (default: `"oauth/authorize"`).
- `:token_url`: The token endpoint (default: `"oauth/token"`).
- `:auth_scheme`: The authentication scheme (`:basic_auth`, `:request_body`, `:tls_client_auth`, `:private_key_jwt`). Default is `:basic_auth`.
- `:connection_opts`: Options for the underlying Faraday connection (timeouts, proxy, etc.).
- `:raise_errors`: Whether to raise `OAuth2::Error` on 400+ responses (default: `true`).

<details markdown="1">
  <summary><em>authorize_url</em> and <em>token_url</em></summary>

### `authorize_url` and `token_url` are on site root (Just Works!)

```ruby
require "oauth2"
client = OAuth2::Client.new("client_id", "client_secret", site: "https://example.org")
# => #<OAuth2::Client:0x00000001204c8288 @id="client_id", @secret="client_sec...
client.auth_code.authorize_url(redirect_uri: "http://localhost:8080/oauth2/callback")
# => "https://example.org/oauth/authorize?client_id=client_id&redirect_uri=http%3A%2F%2Flocalhost%3A8080%2Foauth2%2Fcallback&response_type=code"

access = client.auth_code.get_token("authorization_code_value", redirect_uri: "http://localhost:8080/oauth2/callback", headers: {"Authorization" => "Basic some_password"})
response = access.get("/api/resource", params: {"query_foo" => "bar"})
response.class.name
# => OAuth2::Response
```

### Relative `authorize_url` and `token_url` (Not on site root, Just Works!)

In the above example, the default Authorization URL is `oauth/authorize` and default Access Token URL is `oauth/token`, and, as they are missing a leading `/`, both are relative.

```ruby
client = OAuth2::Client.new("client_id", "client_secret", site: "https://example.org/nested/directory/on/your/server")
# => #<OAuth2::Client:0x00000001204c8288 @id="client_id", @secret="client_sec...
client.auth_code.authorize_url(redirect_uri: "http://localhost:8080/oauth2/callback")
# => "https://example.org/nested/directory/on/your/server/oauth/authorize?client_id=client_id&redirect_uri=http%3A%2F%2Flocalhost%3A8080%2Foauth2%2Fcallback&response_type=code"
```

### Customize `authorize_url` and `token_url`

You can specify custom URLs for authorization and access token, and when using a leading `/` they will _not be relative_, as shown below:

```ruby
client = OAuth2::Client.new(
  "client_id",
  "client_secret",
  site: "https://example.org/nested/directory/on/your/server",
  authorize_url: "/jaunty/authorize/",
  token_url: "/stirrups/access_token"
)
# => #<OAuth2::Client:0x00000001204c8288 @id="client_id", @secret="client_sec...
client.auth_code.authorize_url(redirect_uri: "http://localhost:8080/oauth2/callback")
# => "https://example.org/jaunty/authorize/?client_id=client_id&redirect_uri=http%3A%2F%2Flocalhost%3A8080%2Foauth2%2Fcallback&response_type=code"
client.class.name
# => OAuth2::Client
```

</details>

### Advanced Initializers

```ruby
client = OAuth2::Client.new(id, secret, site: site) do |faraday|
  faraday.request(:url_encoded)
  faraday.adapter(:net_http_persistent)
end
```

### AccessToken Features

Instances of `OAuth2::AccessToken` handle request signing and token expiration.

- **Snake Case & Indifferent Access**: `response.parsed` returns a `SnakyHash` allowing access via string/symbol and snake_case keys even if the provider returns CamelCase.
- **Auto-Refresh**: You can manually check `token.expired?` and call `token.refresh`.
- **Serialization**: Persist tokens using `token.to_hash` and restore via `OAuth2::AccessToken.from_hash(client, hash)`.

### snake_case and indifferent access in Response#parsed

```ruby
response = access.get("/api/resource", params: {"query_foo" => "bar"})
# Even if the actual response is CamelCase. it will be made available as snaky:
JSON.parse(response.body)         # => {"accessToken"=>"aaaaaaaa", "additionalData"=>"additional"}
response.parsed                   # => {"access_token"=>"aaaaaaaa", "additional_data"=>"additional"}
response.parsed.access_token      # => "aaaaaaaa"
response.parsed[:access_token]    # => "aaaaaaaa"
response.parsed.additional_data   # => "additional"
response.parsed[:additional_data] # => "additional"
response.parsed.class.name        # => SnakyHash::StringKeyed (from snaky_hash gem)
```

#### Serialization

As of v2.0.11, if you need to serialize the parsed result, you can!

There are two ways to do this, globally, or discretely.  The discrete way is recommended.

##### Global Serialization Config

Globally configure `SnakyHash::StringKeyed` to use the serializer. Put this in your code somewhere reasonable (like an initializer for Rails).

```ruby
SnakyHash::StringKeyed.class_eval do
  extend SnakyHash::Serializer
end
```

##### Discrete Serialization Config

Discretely configure a custom Snaky Hash class to use the serializer.

```ruby
class MySnakyHash < SnakyHash::StringKeyed
  # Give this hash class `dump` and `load` abilities!
  extend SnakyHash::Serializer
end

# And tell your client to use the custom class in each call:
client = OAuth2::Client.new("client_id", "client_secret", site: "https://example.org/oauth2")
token = client.get_token({snaky_hash_klass: MySnakyHash})
```

##### Serialization Extensions

These extensions work regardless of whether you used the global or discrete config above.

There are a few hacks you may need in your class to support Ruby < 2.4.2 or < 2.6.
They are likely not needed if you are on a newer Ruby.
Expand the examples below, or the [ruby-oauth/snaky_hash](https://gitlab.com/ruby-oauth/snaky_hash) gem,
or [response_spec.rb](https://github.com/ruby-oauth/oauth2/blob/main/spec/oauth2/response_spec.rb), for more ideas, especially if you need to study the hacks for older Rubies.

<details markdown="1">
  <summary>See Examples</summary>

```ruby
class MySnakyHash < SnakyHash::StringKeyed
  # Give this hash class `dump` and `load` abilities!
  extend SnakyHash::Serializer

  #### Serialization Extentions
  #
  # Act on the non-hash values (including the values of hashes) as they are dumped to JSON
  # In other words, this retains nested hashes, and only the deepest leaf nodes become bananas.
  # WARNING: This is a silly example!
  dump_value_extensions.add(:to_fruit) do |value|
    "banana" # => Make values "banana" on dump
  end

  # Act on the non-hash values (including the values of hashes) as they are loaded from the JSON dump
  # In other words, this retains nested hashes, and only the deepest leaf nodes become ***.
  # WARNING: This is a silly example!
  load_value_extensions.add(:to_stars) do |value|
    "***" # Turn dumped bananas into *** when they are loaded
  end

  # Act on the entire hash as it is prepared for dumping to JSON
  # WARNING: This is a silly example!
  dump_hash_extensions.add(:to_cheese) do |value|
    if value.is_a?(Hash)
      value.transform_keys do |key|
        split = key.split("_")
        first_word = split[0]
        key.sub(first_word, "cheese")
      end
    else
      value
    end
  end

  # Act on the entire hash as it is loaded from the JSON dump
  # WARNING: This is a silly example!
  load_hash_extensions.add(:to_pizza) do |value|
    if value.is_a?(Hash)
      res = klass.new
      value.keys.each_with_object(res) do |key, result|
        split = key.split("_")
        last_word = split[-1]
        new_key = key.sub(last_word, "pizza")
        result[new_key] = value[key]
      end
      res
    else
      value
    end
  end
end
```

</details>

#### Prefer camelCase over snake_case? => snaky: false

```ruby
response = access.get("/api/resource", params: {"query_foo" => "bar"}, snaky: false)
JSON.parse(response.body)         # => {"accessToken"=>"aaaaaaaa", "additionalData"=>"additional"}
response.parsed                   # => {"accessToken"=>"aaaaaaaa", "additionalData"=>"additional"}
response.parsed["accessToken"]    # => "aaaaaaaa"
response.parsed["additionalData"] # => "additional"
response.parsed.class.name        # => Hash (just, regular old Hash)
```

<details markdown="1">
  <summary>Debugging & Logging</summary>

Set an environment variable as per usual (e.g. with [dotenv](https://github.com/bkeepers/dotenv)).

```ruby
# will log both request and response, including bodies
ENV["OAUTH_DEBUG"] = "true"
```

By default, debug output will go to `$stdout`. This can be overridden when
initializing your OAuth2::Client.

Sensitive values are filtered from debug logging output using:

- `OAuth2.config[:filtered_label]`
- `OAuth2.config[:filtered_debug_keys]`

Debug logging remains opt-in and should still be used cautiously in production environments.

```ruby
require "oauth2"
client = OAuth2::Client.new(
  "client_id",
  "client_secret",
  site: "https://example.org",
  logger: Logger.new("example.log", "weekly")
)
```

</details>

### Request Target Trust Boundaries

This gem supports request flows that can involve absolute URLs in addition to relative paths.
That flexibility can expand trust boundaries when a token-bearing client is asked to send requests
to caller-provided targets.

Practical guidance:

- prefer relative paths where practical
- do not pass untrusted absolute URLs into token-bearing clients
- validate or allowlist request targets at the application layer today if your deployment has strict trust-boundary requirements

This release line does not yet enforce same-host or allowlist request policy automatically.
If stricter outbound request controls are needed, they should currently be implemented by the calling application.

### OAuth2::Response

The `AccessToken` methods `#get`, `#post`, `#put` and `#delete` and the generic `#request`
will return an instance of the `OAuth2::Response` class.

This instance contains a `#parsed` method that will parse the response body and
return a Hash-like [`SnakyHash::StringKeyed`](https://gitlab.com/ruby-oauth/snaky_hash/-/blob/main/lib/snaky_hash/string_keyed.rb) if the `Content-Type` is `application/x-www-form-urlencoded` or if
the body is a JSON object. It will return an Array if the body is a JSON
array. Otherwise, it will return the original body string.

The original response body, headers, and status can be accessed via their
respective methods.

### OAuth2::AccessToken

If you have an existing Access Token for a user, you can initialize an instance
using various class methods including the standard new, `from_hash` (if you have
a hash of the values), or `from_kvform` (if you have an
`application/x-www-form-urlencoded` encoded string of the values).

Options (since v2.0.x unless noted):

- `expires_latency` (Integer | nil): Seconds to subtract from expires_in when computing #expired? to offset latency.
- `token_name` (String | Symbol | nil): When multiple token-like fields exist in responses, select the field name to use as the access token (since v2.0.10).
- `mode` (Symbol | Proc | Hash): Controls how the token is transmitted on requests made via this AccessToken instance.
  - `:header` — Send as Authorization: Bearer <token> header (default and preferred by OAuth 2.1 draft guidance).
  - `:query` — Send as access_token query parameter (discouraged in general, but required by some providers).
  - Verb-dependent (since v2.0.15): Provide either:
    - a `Proc` taking `|verb|` and returning `:header` or `:query`, or
    - a `Hash` with verb symbols as keys, for example `{get: :query, post: :header, delete: :header}`.

Note: Verb-dependent mode supports providers like Instagram that require query mode for `GET` and header mode for `POST`/`DELETE`

- Verb-dependent mode via `Proc` was added in v2.0.15
- Verb-dependent mode via `Hash` was added in v2.0.16

### OAuth2::Error

On 400+ status code responses, an `OAuth2::Error` will be raised.  If it is a
standard OAuth2 error response, the body will be parsed and `#code` and `#description` will contain the values provided from the error and
`error_description` parameters.  The `#response` property of `OAuth2::Error` will
always contain the `OAuth2::Response` instance.

If you do not want an error to be raised, you may use `:raise_errors => false`
option on initialization of the client.  In this case the `OAuth2::Response`
instance will be returned as usual and on 400+ status code responses, the
Response instance will contain the `OAuth2::Error` instance.

### Authorization Grants

Currently, the Authorization Code, Implicit, Resource Owner Password Credentials, Client Credentials, and Assertion
authentication grant types have helper strategy classes that simplify client
use. They are available via the [`#auth_code`](https://gitlab.com/ruby-oauth/oauth2/-/blob/main/lib/oauth2/strategy/auth_code.rb),
[`#implicit`](https://gitlab.com/ruby-oauth/oauth2/-/blob/main/lib/oauth2/strategy/implicit.rb),
[`#password`](https://gitlab.com/ruby-oauth/oauth2/-/blob/main/lib/oauth2/strategy/password.rb),
[`#client_credentials`](https://gitlab.com/ruby-oauth/oauth2/-/blob/main/lib/oauth2/strategy/client_credentials.rb), and
[`#assertion`](https://gitlab.com/ruby-oauth/oauth2/-/blob/main/lib/oauth2/strategy/assertion.rb) methods respectively.

#### OAuth 2.1 (draft) Note:

- **PKCE** is required for all OAuth clients using the authorization code flow (especially public clients). Implement PKCE in your app when required by your provider. See RFC 7636 and RFC 8252.
- **Implicit grant** (response_type=token) and **Resource Owner Password Credentials grant** are omitted from OAuth 2.1; they remain here for OAuth 2.0 compatibility but should be avoided for new apps.
- **Redirect URIs** must be compared using exact string matching by the Authorization Server.

<details markdown="1">
  <summary>OAuth 2.1 (draft) References</summary>

- OAuth 2.1 draft: https://datatracker.ietf.org/doc/html/draft-ietf-oauth-v2-1-13
- Aaron Parecki: https://aaronparecki.com/2019/12/12/21/its-time-for-oauth-2-dot-1
- FusionAuth: https://fusionauth.io/blog/2020/04/15/whats-new-in-oauth-2-1
- Okta: https://developer.okta.com/blog/2019/12/13/oauth-2-1-how-many-rfcs
- Video: https://www.youtube.com/watch?v=g_aVPdwBTfw
- Differences overview: https://fusionauth.io/learn/expert-advice/oauth/differences-between-oauth-2-oauth-2-1/

</details>

These aren't full examples, but demonstrative of the differences between usage for each strategy.

```ruby
auth_url = client.auth_code.authorize_url(redirect_uri: "http://localhost:8080/oauth/callback")
access = client.auth_code.get_token("code_value", redirect_uri: "http://localhost:8080/oauth/callback")

auth_url = client.implicit.authorize_url(redirect_uri: "http://localhost:8080/oauth/callback")
# get the token params in the callback and
access = OAuth2::AccessToken.from_kvform(client, query_string)

access = client.password.get_token("username", "password")

access = client.client_credentials.get_token

# Client Assertion Strategy
# see: https://tools.ietf.org/html/rfc7523
claimset = {
  iss: "http://localhost:3001",
  aud: "http://localhost:8080/oauth2/token",
  sub: "me@example.com",
  exp: Time.now.utc.to_i + 3600,
}
assertion_params = [claimset, "HS256", "secret_key"]
access = client.assertion.get_token(assertion_params)

# The `access` (i.e. access token) is then used like so:
access.token # actual access_token string, if you need it somewhere
access.get("/api/stuff") # making api calls with access token
```

If you want to specify additional headers to be sent out with the
request, add a 'headers' hash under 'params':

```ruby
access = client.auth_code.get_token("code_value", redirect_uri: "http://localhost:8080/oauth/callback", headers: {"Some" => "Header"})
```

You can always use the `#request` method on the `OAuth2::Client` instance to make
requests for tokens for any Authentication grant type.

## 🦷 FLOSS Funding

While ruby-oauth tools are free software and will always be, the project would benefit immensely from some funding.
Raising a monthly budget of... "dollars" would make the project more sustainable.

We welcome both individual and corporate sponsors! We also offer a
wide array of funding channels to account for your preferences.
Currently, [Open Collective][🖇osc] is our preferred funding platform.

**If you're working in a company that's making significant use of ruby-oauth tools we'd
appreciate it if you suggest to your company to become a ruby-oauth sponsor.**

You can support the development of ruby-oauth tools via
[GitHub Sponsors][🖇sponsor],
[Liberapay][⛳liberapay],
[PayPal][🖇paypal],
[Open Collective][🖇osc]
and [Tidelift][🏙️entsup-tidelift].

| 📍 NOTE |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| If doing a sponsorship in the form of donation is problematic for your company <br/> from an accounting standpoint, we'd recommend the use of Tidelift, <br/> where you can get a support-like subscription instead. |

### Open Collective for Individuals

Support us with a monthly donation and help us continue our activities. [[Become a backer](https://opencollective.com/ruby-oauth#backer)]

NOTE: [kettle-readme-backers][kettle-readme-backers] updates this list every day, automatically.

<!-- OPENCOLLECTIVE-INDIVIDUALS:START -->
No backers yet. Be the first!
<!-- OPENCOLLECTIVE-INDIVIDUALS:END -->

### Open Collective for Organizations

Become a sponsor and get your logo on our README on GitHub with a link to your site. [[Become a sponsor](https://opencollective.com/ruby-oauth#sponsor)]

NOTE: [kettle-readme-backers][kettle-readme-backers] updates this list every day, automatically.

<!-- OPENCOLLECTIVE-ORGANIZATIONS:START -->
No sponsors yet. Be the first!
<!-- OPENCOLLECTIVE-ORGANIZATIONS:END -->

[kettle-readme-backers]: https://github.com/ruby-oauth/oauth2/blob/main/exe/kettle-readme-backers

### Another way to support open-source

I’m driven by a passion to foster a thriving open-source community – a space where people can tackle complex problems, no matter how small. Revitalizing libraries that have fallen into disrepair, and building new libraries focused on solving real-world challenges, are my passions. I was recently affected by layoffs, and the tech jobs market is unwelcoming. I’m reaching out here because your support would significantly aid my efforts to provide for my family, and my farm (11 🐔 chickens, 2 🐶 dogs, 3 🐰 rabbits, 8 🐈‍ cats).

If you work at a company that uses my work, please encourage them to support me as a corporate sponsor. My work on gems you use might show up in `bundle fund`.

I’m developing a new library, [floss_funding][🖇floss-funding-gem], designed to empower open-source developers like myself to get paid for the work we do, in a sustainable way. Please give it a look.

**[Floss-Funding.dev][🖇floss-funding.dev]: 👉️ No network calls. 👉️ No tracking. 👉️ No oversight. 👉️ Minimal crypto hashing. 💡 Easily disabled nags**

[![OpenCollective Backers][🖇osc-backers-i]][🖇osc-backers] [![OpenCollective Sponsors][🖇osc-sponsors-i]][🖇osc-sponsors] [![Sponsor Me on Github][🖇sponsor-img]][🖇sponsor] [![Liberapay Goal Progress][⛳liberapay-img]][⛳liberapay] [![Donate on PayPal][🖇paypal-img]][🖇paypal] [![Buy me a coffee][🖇buyme-small-img]][🖇buyme] [![Donate on Polar][🖇polar-img]][🖇polar] [![Donate to my FLOSS efforts at ko-fi.com][🖇kofi-img]][🖇kofi] [![Donate to my FLOSS efforts using Patreon][🖇patreon-img]][🖇patreon]

## 🔐 Security

See [SECURITY.md][🔐security].

## 🤝 Contributing

If you need some ideas of where to help, you could work on adding more code coverage,
or if it is already 💯 (see [below](#code-coverage)) check [issues][🤝gh-issues] or [PRs][🤝gh-pulls],
or use the gem and think about how it could be better.

We [![Keep A Changelog][📗keep-changelog-img]][📗keep-changelog] so if you make changes, remember to update it.

See [CONTRIBUTING.md][🤝contributing] for more detailed instructions.

### 🚀 Release Instructions

See [CONTRIBUTING.md][🤝contributing].

### Code Coverage

<details markdown="1">
<summary>Coverage service badges</summary>

[![Coverage Graph][🏀codecov-g]][🏀codecov]

[![Coveralls Test Coverage][🏀coveralls-img]][🏀coveralls]

[![QLTY Test Coverage][🏀qlty-covi]][🏀qlty-cov]

</details>

### 🪇 Code of Conduct

Everyone interacting with this project's codebases, issue trackers,
chat rooms and mailing lists agrees to follow the [![Contributor Covenant 2.1][🪇conduct-img]][🪇conduct].

## 🌈 Contributors

[![Contributors][🖐contributors-img]][🖐contributors]

Made with [contributors-img][🖐contrib-rocks].

Also see GitLab Contributors: [https://gitlab.com/ruby-oauth/oauth2/-/graphs/main][🚎contributors-gl]

<details>
 <summary>⭐️ Star History</summary>

<a href="https://star-history.com/ruby-oauth/oauth2&Date">
 <picture>
 <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/svg?repos=ruby-oauth/oauth2&type=Date&theme=dark" />
 <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/svg?repos=ruby-oauth/oauth2&type=Date" />
 <img alt="Star History Chart" src="https://api.star-history.com/svg?repos=ruby-oauth/oauth2&type=Date" />
 </picture>
</a>

</details>

## 📌 Versioning

This library follows [![Semantic Versioning 2.0.0][📌semver-img]][📌semver] for its public API where practical.
For most applications, prefer the [Pessimistic Version Constraint][📌pvc] with two digits of precision.

For example:

```ruby
spec.add_dependency("oauth2", "~> 2.0")
```

<details markdown="1">
<summary>📌 Is "Platform Support" part of the public API? More details inside.</summary>

Dropping support for a platform can be a breaking change for affected users.
If a release changes supported platforms, it should be called out clearly in the changelog and versioned with that impact in mind.

To get a better understanding of how SemVer is intended to work over a project's lifetime,
read this article from the creator of SemVer:

- ["Major Version Numbers are Not Sacred"][📌major-versions-not-sacred]

</details>

See [CHANGELOG.md][📌changelog] for a list of releases.

## 📄 License

The gem is available as open source under the terms of
the [MIT](MIT.md) [![License: MIT][📄license-img]][📄license-ref].

### © Copyright

See [LICENSE.md][📄license] for the official copyright notice.

<details markdown="1">
<summary>Copyright holders</summary>

- Copyright (c) 2010-2014, 2016-2017 Erik Michaels-Ober
- Copyright (c) 2010 Jeremy Kemper
- Copyright (c) 2010-2011 Michael Bleigh
- Copyright (c) 2010-2011 Paul Walker
- Copyright (c) 2010 rick
- Copyright (c) 2010 Tim Habermaas
- Copyright (c) 2010 Wynn Netherland
- Copyright (c) 2011 Alexander Lang
- Copyright (c) 2011 Alexander Lang
- Copyright (c) 2011 Greg Spurrier
- Copyright (c) 2011 Jay Adkisson
- Copyright (c) 2011 Luke Saunders
- Copyright (c) 2011 Paul Walker
- Copyright (c) 2011 Simon Gate
- Copyright (c) 2012 Bas Vodde
- Copyright (c) 2012 Damian Janowski
- Copyright (c) 2012 Daniël van de Burgt
- Copyright (c) 2012 Dorren Chen
- Copyright (c) 2012 Igor Sales
- Copyright (c) 2012 Leigh Caplan
- Copyright (c) 2012 Michael Andrews
- Copyright (c) 2012 Omer Rauchwerger
- Copyright (c) 2012 Saverio Trioni
- Copyright (c) 2012 Trent Ogren
- Copyright (c) 2012 Vsevolod Romashov
- Copyright (c) 2013 Antonio Tapiador del Dujo
- Copyright (c) 2013 Eduardo Gurgel
- Copyright (c) 2013 Geostellar Developer
- Copyright (c) 2013-2014, 2018 Niels Ganser
- Copyright (c) 2013 Rainux Luo
- Copyright (c) 2013 Taylor Hedberg
- Copyright (c) 2013 Tim Clem
- Copyright (c) 2014 Dave Stevens
- Copyright (c) 2014 Ellis Berner
- Copyright (c) 2014 Frank Macreery
- Copyright (c) 2014 Michael Bleigh
- Copyright (c) 2014 Olivier Lacan
- Copyright (c) 2014 Peter Souter
- Copyright (c) 2014 Ryan Williams
- Copyright (c) 2015 Andrew Cantino and Jeff Moore
- Copyright (c) 2015 Thomas Walpole
- Copyright (c) 2016 Bo Jeanes
- Copyright (c) 2016 Cody Cutrer
- Copyright (c) 2016 Edward Rudd
- Copyright (c) 2016 Lawrence Oluyede
- Copyright (c) 2016 Linus Pettersson
- Copyright (c) 2016 Motoshi Nishihira
- Copyright (c) 2017 Adrian Setyadi
- Copyright (c) 2017-2018 Benjamin Quorning
- Copyright (c) 2017 Christoph Petschnig
- Copyright (c) 2017, 2022 Nathaniel Bibler
- Copyright (c) 2017 Oleg
- Copyright (c) 2017 Samuel Cochran
- Copyright (c) 2017 tetsuya
- Copyright (c) 2017 Yury Velikanau
- Copyright (c) 2018 Alex Kowalczuk
- Copyright (c) 2018 asm__
- Copyright (c) 2018 David Christensen
- Copyright (c) 2018 fossabot
- Copyright (c) 2018 Jeff Moore
- Copyright (c) 2018 Jeff Moore
- Copyright (c) 2018 Jonathan del Strother
- Copyright (c) 2018 Joseph Page
- Copyright (c) 2018 Joseph Page
- Copyright (c) 2018 Lomey
- Copyright (c) 2018 Markus Bengts
- Copyright (c) 2018 Mathias Klippinge
- Copyright (c) 2018 nikz
- Copyright (c) 2018-2019, 2021-2022, 2024-2026 Peter H. Boling
- Copyright (c) 2019 Daniel Fockler
- Copyright (c) 2019 Elliot Crosby-McCullough
- Copyright (c) 2019 João Paulo
- Copyright (c) 2019 Orien Madgwick
- Copyright (c) 2019 Ryan T. Hosford
- Copyright (c) 2019 Tom Corley
- Copyright (c) 2020 anvox
- Copyright (c) 2020 Jesse Cotton
- Copyright (c) 2020 Olle Jonsson
- Copyright (c) 2020 Stephen Reid
- Copyright (c) 2021 Anders Carling
- Copyright (c) 2021 dobon
- Copyright (c) 2021 Jan Zaydowicz
- Copyright (c) 2021 Nicholas Palaniuk
- Copyright (c) 2021-2022 Stan Hu
- Copyright (c) 2022 Benjamin Quorning
- Copyright (c) 2022 Bouke van der Bijl
- Copyright (c) 2022 nov
- Copyright (c) 2022 Rick Selby
- Copyright (c) 2022 Ryo Takahashi
- Copyright (c) 2023 Jessie Young
- Copyright (c) 2023 Карим Гимадеев
- Copyright (c) 2024 Aboling0
- Copyright (c) 2024 Elise Wood
- Copyright (c) 2024 Manuel van Rijn
- Copyright (c) 2025-2026 Annibelle Boling
- Copyright (c) 2025 Mark James
- Copyright (c) 2025 Mridang Agarwalla
- Copyright (c) 2025 Sasa Rosic
- Copyright (c) 2026 Jonathan Grinstead
- Copyright (c) 2026 kain
- Copyright (c) 2026 StepSecurity Bot

</details>

## 🤑 A request for help

Maintainers have teeth and need to pay their dentists.
After getting laid off in an RIF in March, and encountering difficulty finding a new one,
I began spending most of my time building open source tools.
I'm hoping to be able to pay for my kids' health insurance this month,
so if you value the work I am doing, I need your support.
Please consider sponsoring me or the project.

To join the community or get help 👇️ Join the Discord.

[![Live Chat on Discord][✉️discord-invite-img-ftb]][✉️discord-invite]

To say "thanks!" ☝️ Join the Discord or 👇️ send money.

[![Sponsor ruby-oauth/oauth2 on Open Source Collective][🖇osc-all-bottom-img]][🖇osc] 💌 [![Sponsor me on GitHub Sponsors][🖇sponsor-bottom-img]][🖇sponsor] 💌 [![Sponsor me on Liberapay][⛳liberapay-bottom-img]][⛳liberapay] 💌 [![Donate on PayPal][🖇paypal-bottom-img]][🖇paypal]

### Please give the project a star ⭐ ♥.

Many parts of this project are actively managed by a [kettle-jem](https://github.com/structuredmerge/structuredmerge-ruby/tree/main/gems/kettle-jem) smart template utilizing [StructuredMerge.org](https://structuredmerge.org) merge contracts.

Thanks for RTFM. ☺️

[⛳liberapay-img]: https://img.shields.io/liberapay/goal/pboling.svg?logo=liberapay&color=a51611&style=flat
[⛳liberapay-bottom-img]: https://img.shields.io/liberapay/goal/pboling.svg?style=for-the-badge&logo=liberapay&color=a51611
[⛳liberapay]: https://liberapay.com/pboling/donate
[🖇osc-all-img]: https://img.shields.io/opencollective/all/ruby-oauth
[🖇osc-sponsors-img]: https://img.shields.io/opencollective/sponsors/ruby-oauth
[🖇osc-backers-img]: https://img.shields.io/opencollective/backers/ruby-oauth
[🖇osc-backers]: https://opencollective.com/ruby-oauth#backer
[🖇osc-backers-i]: https://opencollective.com/ruby-oauth/backers/badge.svg?style=flat
[🖇osc-sponsors]: https://opencollective.com/ruby-oauth#sponsor
[🖇osc-sponsors-i]: https://opencollective.com/ruby-oauth/sponsors/badge.svg?style=flat
[🖇osc-all-bottom-img]: https://img.shields.io/opencollective/all/ruby-oauth?style=for-the-badge
[🖇osc-sponsors-bottom-img]: https://img.shields.io/opencollective/sponsors/ruby-oauth?style=for-the-badge
[🖇osc-backers-bottom-img]: https://img.shields.io/opencollective/backers/ruby-oauth?style=for-the-badge
[🖇osc]: https://opencollective.com/ruby-oauth
[🖇sponsor-img]: https://img.shields.io/badge/Sponsor_Me!-pboling.svg?style=social&logo=github
[🖇sponsor-bottom-img]: https://img.shields.io/badge/Sponsor_Me!-pboling-blue?style=for-the-badge&logo=github
[🖇sponsor]: https://github.com/sponsors/pboling
[🖇polar-img]: https://img.shields.io/badge/polar-donate-a51611.svg?style=flat
[🖇polar]: https://polar.sh/pboling
[🖇kofi-img]: https://img.shields.io/badge/ko--fi-%E2%9C%93-a51611.svg?style=flat
[🖇kofi]: https://ko-fi.com/pboling
[🖇patreon-img]: https://img.shields.io/badge/patreon-donate-a51611.svg?style=flat
[🖇patreon]: https://patreon.com/galtzo
[🖇buyme-small-img]: https://img.shields.io/badge/buy_me_a_coffee-%E2%9C%93-a51611.svg?style=flat
[🖇buyme-img]: https://img.buymeacoffee.com/button-api/?text=Buy%20me%20a%20latte&emoji=&slug=pboling&button_colour=FFDD00&font_colour=000000&font_family=Cookie&outline_colour=000000&coffee_colour=ffffff
[🖇buyme]: https://www.buymeacoffee.com/pboling
[🖇paypal-img]: https://img.shields.io/badge/donate-paypal-a51611.svg?style=flat&logo=paypal
[🖇paypal-bottom-img]: https://img.shields.io/badge/donate-paypal-a51611.svg?style=for-the-badge&logo=paypal&color=0A0A0A
[🖇paypal]: https://www.paypal.com/paypalme/peterboling
[🖇floss-funding.dev]: https://floss-funding.dev
[🖇floss-funding-gem]: https://github.com/galtzo-floss/floss_funding
[✉️discord-invite]: https://discord.gg/3qme4XHNKN
[✉️discord-invite-img-ftb]: https://img.shields.io/discord/1373797679469170758?style=for-the-badge&logo=discord
[✉️ruby-friends-img]: https://img.shields.io/badge/daily.dev-%F0%9F%92%8E_Ruby_Friends-0A0A0A?style=for-the-badge&logo=dailydotdev&logoColor=white
[✉️ruby-friends]: https://app.daily.dev/squads/rubyfriends

[✇bundle-group-pattern]: https://gist.github.com/pboling/4564780
[⛳️gem-namespace]: https://github.com/ruby-oauth/oauth2
[⛳️namespace-img]: https://img.shields.io/badge/namespace-OAuth2-3C2D2D.svg?style=square&logo=ruby&logoColor=white
[⛳️gem-name]: https://bestgems.org/gems/oauth2
[⛳️name-img]: https://img.shields.io/badge/name-oauth2-3C2D2D.svg?style=square&logo=rubygems&logoColor=red
[⛳️tag-img]: https://img.shields.io/github/tag/ruby-oauth/oauth2.svg
[⛳️tag]: https://github.com/ruby-oauth/oauth2/releases
[🚂maint-blog]: http://www.railsbling.com/tags/oauth2
[🚂maint-blog-img]: https://img.shields.io/badge/blog-railsbling-0093D0.svg?style=for-the-badge&logo=rubyonrails&logoColor=orange
[🚂maint-contact]: http://www.railsbling.com/contact
[🚂maint-contact-img]: https://img.shields.io/badge/Contact-Maintainer-0093D0.svg?style=flat&logo=rubyonrails&logoColor=red
[💖🖇linkedin]: http://www.linkedin.com/in/peterboling
[💖🖇linkedin-img]: https://img.shields.io/badge/LinkedIn-Profile-0B66C2?style=flat&logo=newjapanprowrestling
[💖✌️wellfound]: https://wellfound.com/u/peter-boling
[💖✌️wellfound-img]: https://img.shields.io/badge/peter--boling-orange?style=flat&logo=wellfound
[💖💲crunchbase]: https://www.crunchbase.com/person/peter-boling
[💖💲crunchbase-img]: https://img.shields.io/badge/peter--boling-purple?style=flat&logo=crunchbase
[💖🐘ruby-mast]: https://ruby.social/@galtzo
[💖🐘ruby-mast-img]: https://img.shields.io/mastodon/follow/109447111526622197?domain=https://ruby.social&style=flat&logo=mastodon&label=Ruby%20@galtzo
[💖🦋bluesky]: https://bsky.app/profile/galtzo.com
[💖🦋bluesky-img]: https://img.shields.io/badge/@galtzo.com-0285FF?style=flat&logo=bluesky&logoColor=white
[💖🌳linktree]: https://linktr.ee/galtzo
[💖🌳linktree-img]: https://img.shields.io/badge/galtzo-purple?style=flat&logo=linktree
[💖💁🏼‍♂️devto]: https://dev.to/galtzo
[💖💁🏼‍♂️devto-img]: https://img.shields.io/badge/dev.to-0A0A0A?style=flat&logo=devdotto&logoColor=white
[💖💁🏼‍♂️aboutme]: https://about.me/peter.boling
[💖💁🏼‍♂️aboutme-img]: https://img.shields.io/badge/about.me-0A0A0A?style=flat&logo=aboutme&logoColor=white
[💖🧊berg]: https://codeberg.org/pboling
[💖🐙hub]: https://github.org/pboling
[💖🛖hut]: https://sr.ht/~galtzo/
[💖🧪lab]: https://gitlab.com/pboling
[👨🏼‍🏫expsup-upwork]: https://www.upwork.com/freelancers/~014942e9b056abdf86?mp_source=share
[👨🏼‍🏫expsup-upwork-img]: https://img.shields.io/badge/UpWork-13544E?style=for-the-badge&logo=Upwork&logoColor=white
[👨🏼‍🏫expsup-codementor]: https://www.codementor.io/peterboling?utm_source=github&utm_medium=button&utm_term=peterboling&utm_campaign=github
[👨🏼‍🏫expsup-codementor-img]: https://img.shields.io/badge/CodeMentor-Get_Help-1abc9c?style=for-the-badge&logo=CodeMentor&logoColor=white
[🏙️entsup-tidelift]: https://tidelift.com/subscription/pkg/rubygems-oauth2?utm_source=rubygems-oauth2&utm_medium=referral&utm_campaign=readme
[🏙️entsup-tidelift-img]: https://img.shields.io/badge/Tidelift_and_Sonar-Enterprise_Support-FD3456?style=for-the-badge&logo=sonar&logoColor=white
[🏙️entsup-tidelift-sonar]: https://blog.tidelift.com/tidelift-joins-sonar
[💁🏼‍♂️peterboling]: http://www.peterboling.com
[🚂railsbling]: http://www.railsbling.com
[📜src-gl-img]: https://img.shields.io/badge/GitLab-FBA326?style=for-the-badge&logo=Gitlab&logoColor=orange
[📜src-gl]: https://gitlab.com/ruby-oauth/oauth2
[📜src-cb-img]: https://img.shields.io/badge/CodeBerg-4893CC?style=for-the-badge&logo=CodeBerg&logoColor=blue
[📜src-cb]: https://codeberg.org/ruby-oauth/oauth2
[📜src-gh-img]: https://img.shields.io/badge/GitHub-238636?style=for-the-badge&logo=Github&logoColor=green
[📜src-gh]: https://github.com/ruby-oauth/oauth2
[📜docs-cr-rd-img]: https://img.shields.io/badge/RubyDoc-Current_Release-943CD2?style=for-the-badge&logo=readthedocs&logoColor=white
[📜docs-head-rd-img]: https://img.shields.io/badge/YARD_on_Galtzo.com-HEAD-943CD2?style=for-the-badge&logo=readthedocs&logoColor=white
[📜gl-wiki]: https://gitlab.com/ruby-oauth/oauth2/-/wikis/home
[📜gh-wiki]: https://github.com/ruby-oauth/oauth2/wiki
[📜gl-wiki-img]: https://img.shields.io/badge/wiki-gitlab-943CD2.svg?style=for-the-badge&logo=gitlab&logoColor=white
[📜gh-wiki-img]: https://img.shields.io/badge/wiki-github-943CD2.svg?style=for-the-badge&logo=github&logoColor=white
[👽dl-rank]: https://bestgems.org/gems/oauth2
[👽dl-ranki]: https://img.shields.io/gem/rd/oauth2.svg
[👽version]: https://bestgems.org/gems/oauth2
[👽versioni]: https://img.shields.io/gem/v/oauth2.svg
[🏀qlty-mnt]: https://qlty.sh/gh/ruby-oauth/projects/oauth2
[🏀qlty-mnti]: https://qlty.sh/gh/ruby-oauth/projects/oauth2/maintainability.svg
[🏀qlty-cov]: https://qlty.sh/gh/ruby-oauth/projects/oauth2/metrics/code?sort=coverageRating
[🏀qlty-covi]: https://qlty.sh/gh/ruby-oauth/projects/oauth2/coverage.svg
[🏀codecov]: https://codecov.io/gh/ruby-oauth/oauth2
[🏀codecovi]: https://codecov.io/gh/ruby-oauth/oauth2/graph/badge.svg
[🏀coveralls]: https://coveralls.io/github/ruby-oauth/oauth2?branch=main
[🏀coveralls-img]: https://coveralls.io/repos/github/ruby-oauth/oauth2/badge.svg?branch=main
[🚎ruby-2.4-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/ruby-2.4.yml
[🚎ruby-2.5-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/ruby-2.5.yml
[🚎ruby-2.6-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/ruby-2.6.yml
[🚎ruby-2.7-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/ruby-2.7.yml
[🚎ruby-3.0-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/ruby-3.0.yml
[🚎ruby-3.1-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/ruby-3.1.yml
[🚎ruby-3.2-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/ruby-3.2.yml
[🚎ruby-3.3-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/ruby-3.3.yml
[🚎ruby-3.4-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/ruby-3.4.yml
[🚎jruby-9.2-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/jruby-9.2.yml
[🚎jruby-9.3-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/jruby-9.3.yml
[🚎jruby-9.4-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/jruby-9.4.yml
[🚎truby-22.3-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/truffleruby-22.3.yml
[🚎truby-23.0-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/truffleruby-23.0.yml
[🚎truby-23.1-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/truffleruby-23.1.yml
[🚎truby-24.2-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/truffleruby-24.2.yml
[🚎truby-25.0-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/truffleruby-25.0.yml
[🚎2-cov-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/coverage.yml
[🚎2-cov-wfi]: https://github.com/ruby-oauth/oauth2/actions/workflows/coverage.yml/badge.svg
[🚎3-hd-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/heads.yml
[🚎3-hd-wfi]: https://github.com/ruby-oauth/oauth2/actions/workflows/heads.yml/badge.svg
[🚎5-st-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/style.yml
[🚎5-st-wfi]: https://github.com/ruby-oauth/oauth2/actions/workflows/style.yml/badge.svg
[🚎9-t-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/truffle.yml
[🚎9-t-wfi]: https://github.com/ruby-oauth/oauth2/actions/workflows/truffle.yml/badge.svg
[🚎10-j-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/jruby.yml
[🚎10-j-wfi]: https://github.com/ruby-oauth/oauth2/actions/workflows/jruby.yml/badge.svg
[🚎11-c-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/current.yml
[🚎11-c-wfi]: https://github.com/ruby-oauth/oauth2/actions/workflows/current.yml/badge.svg
[🚎12-crh-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/dep-heads.yml
[🚎12-crh-wfi]: https://github.com/ruby-oauth/oauth2/actions/workflows/dep-heads.yml/badge.svg
[🚎13-🔒️-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/locked_deps.yml
[🚎13-🔒️-wfi]: https://github.com/ruby-oauth/oauth2/actions/workflows/locked_deps.yml/badge.svg
[🚎14-🔓️-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/unlocked_deps.yml
[🚎14-🔓️-wfi]: https://github.com/ruby-oauth/oauth2/actions/workflows/unlocked_deps.yml/badge.svg
[🚎15-🪪-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/license-eye.yml
[🚎15-🪪-wfi]: https://github.com/ruby-oauth/oauth2/actions/workflows/license-eye.yml/badge.svg
[💎ruby-2.2i]: https://img.shields.io/badge/Ruby-2.2_(%F0%9F%9A%ABCI)-AABBCC?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-2.3i]: https://img.shields.io/badge/Ruby-2.3_(%F0%9F%9A%ABCI)-AABBCC?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-2.4i]: https://img.shields.io/badge/Ruby-2.4-DF00CA?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-2.5i]: https://img.shields.io/badge/Ruby-2.5-DF00CA?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-2.6i]: https://img.shields.io/badge/Ruby-2.6-DF00CA?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-2.7i]: https://img.shields.io/badge/Ruby-2.7-DF00CA?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-3.0i]: https://img.shields.io/badge/Ruby-3.0-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-3.1i]: https://img.shields.io/badge/Ruby-3.1-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-3.2i]: https://img.shields.io/badge/Ruby-3.2-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-3.3i]: https://img.shields.io/badge/Ruby-3.3-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-3.4i]: https://img.shields.io/badge/Ruby-3.4-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-4.0i]: https://img.shields.io/badge/Ruby-4.0-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-c-i]: https://img.shields.io/badge/Ruby-current-CC342D?style=for-the-badge&logo=ruby&logoColor=green
[💎ruby-headi]: https://img.shields.io/badge/Ruby-HEAD-CC342D?style=for-the-badge&logo=ruby&logoColor=blue
[💎truby-22.3i]: https://img.shields.io/badge/Truffle_Ruby-22.3-34BCB1?style=for-the-badge&logo=ruby&logoColor=pink
[💎truby-23.0i]: https://img.shields.io/badge/Truffle_Ruby-23.0-34BCB1?style=for-the-badge&logo=ruby&logoColor=pink
[💎truby-23.1i]: https://img.shields.io/badge/Truffle_Ruby-23.1-34BCB1?style=for-the-badge&logo=ruby&logoColor=pink
[💎truby-24.2i]: https://img.shields.io/badge/Truffle_Ruby-24.2-34BCB1?style=for-the-badge&logo=ruby&logoColor=pink
[💎truby-25.0i]: https://img.shields.io/badge/Truffle_Ruby-25.0-34BCB1?style=for-the-badge&logo=ruby&logoColor=pink
[💎truby-c-i]: https://img.shields.io/badge/Truffle_Ruby-current-34BCB1?style=for-the-badge&logo=ruby&logoColor=green
[💎jruby-9.2i]: https://img.shields.io/badge/JRuby-9.2-FBE742?style=for-the-badge&logo=ruby&logoColor=red
[💎jruby-9.3i]: https://img.shields.io/badge/JRuby-9.3-FBE742?style=for-the-badge&logo=ruby&logoColor=red
[💎jruby-9.4i]: https://img.shields.io/badge/JRuby-9.4-FBE742?style=for-the-badge&logo=ruby&logoColor=red
[💎jruby-c-i]: https://img.shields.io/badge/JRuby-current-FBE742?style=for-the-badge&logo=ruby&logoColor=green
[💎jruby-headi]: https://img.shields.io/badge/JRuby-HEAD-FBE742?style=for-the-badge&logo=ruby&logoColor=blue
[🤝gh-issues]: https://github.com/ruby-oauth/oauth2/issues
[🤝gh-pulls]: https://github.com/ruby-oauth/oauth2/pulls
[🤝gl-issues]: https://gitlab.com/ruby-oauth/oauth2/-/issues
[🤝gl-pulls]: https://gitlab.com/ruby-oauth/oauth2/-/merge_requests
[🤝cb-issues]: https://codeberg.org/ruby-oauth/oauth2/issues
[🤝cb-pulls]: https://codeberg.org/ruby-oauth/oauth2/pulls
[🤝cb-donate]: https://donate.codeberg.org/
[🤝contributing]: https://github.com/ruby-oauth/oauth2/blob/main/CONTRIBUTING.md
[🏀codecov-g]: https://codecov.io/gh/ruby-oauth/oauth2/graph/badge.svg
[🖐contrib-rocks]: https://contrib.rocks
[🖐contributors]: https://github.com/ruby-oauth/oauth2/graphs/contributors
[🖐contributors-img]: https://contrib.rocks/image?repo=ruby-oauth/oauth2
[🚎contributors-gl]: https://gitlab.com/ruby-oauth/oauth2/-/graphs/main
[🪇conduct]: https://github.com/ruby-oauth/oauth2/blob/main/CODE_OF_CONDUCT.md
[🪇conduct-img]: https://img.shields.io/badge/Contributor_Covenant-2.1-259D6C.svg
[📌pvc]: http://guides.rubygems.org/patterns/#pessimistic-version-constraint
[📌semver]: https://semver.org/spec/v2.0.0.html
[📌semver-img]: https://img.shields.io/badge/semver-2.0.0-259D6C.svg?style=flat
[📌semver-breaking]: https://github.com/semver/semver/issues/716#issuecomment-869336139
[📌major-versions-not-sacred]: https://tom.preston-werner.com/2022/05/23/major-version-numbers-are-not-sacred.html
[📌changelog]: https://github.com/ruby-oauth/oauth2/blob/main/CHANGELOG.md
[📗keep-changelog]: https://keepachangelog.com/en/1.0.0/
[📗keep-changelog-img]: https://img.shields.io/badge/keep--a--changelog-1.0.0-34495e.svg?style=flat
[📌gitmoji]: https://gitmoji.dev
[📌gitmoji-img]: https://img.shields.io/badge/gitmoji_commits-%20%F0%9F%98%9C%20%F0%9F%98%8D-34495e.svg?style=flat-square
[🧮kloc]: https://www.youtube.com/watch?v=dQw4w9WgXcQ
[🧮kloc-img]: https://img.shields.io/badge/KLOC-0.542-FFDD67.svg?style=for-the-badge&logo=YouTube&logoColor=blue
[🔐security]: https://github.com/ruby-oauth/oauth2/blob/main/SECURITY.md
[🔐security-img]: https://img.shields.io/badge/security-policy-259D6C.svg?style=flat
[📄copyright-notice-explainer]: https://opensource.stackexchange.com/questions/5778/why-do-licenses-such-as-the-mit-license-specify-a-single-year
[📄license]: LICENSE.md
[📄license-ref]: MIT.md
[📄license-img]: https://img.shields.io/badge/License-MIT-259D6C.svg
[📄license-compat]: https://www.apache.org/legal/resolved.html#category-a
[📄license-compat-img]: https://img.shields.io/badge/Apache_Compatible:_Category_A-✓-259D6C.svg?style=flat&logo=Apache

[📄ilo-declaration]: https://www.ilo.org/declaration/lang--en/index.htm
[📄ilo-declaration-img]: https://img.shields.io/badge/ILO_Fundamental_Principles-✓-259D6C.svg?style=flat
[🚎yard-current]: http://rubydoc.info/gems/oauth2
[🚎yard-head]: https://oauth2.galtzo.com
[💎stone_checksums]: https://github.com/galtzo-floss/stone_checksums
[💎SHA_checksums]: https://gitlab.com/ruby-oauth/oauth2/-/tree/main/checksums
[💎rlts]: https://github.com/rubocop-lts/rubocop-lts
[💎rlts-img]: https://img.shields.io/badge/code_style_&_linting-rubocop--lts-34495e.svg?plastic&logo=ruby&logoColor=white
[💎appraisal2]: https://github.com/appraisal-rb/appraisal2
[💎appraisal2-img]: https://img.shields.io/badge/appraised_by-appraisal2-34495e.svg?plastic&logo=ruby&logoColor=white
[💎d-in-dvcs]: https://railsbling.com/posts/dvcs/put_the_d_in_dvcs/

<!-- kettle-jem:metadata:start -->
| Field | Value |
|---|---|
| Package | oauth2 |
| Description | 🔐 A Ruby wrapper for the OAuth 2.0 Authorization Framework, including the OAuth 2.1 draft spec, and OpenID Connect (OIDC) |
| Homepage | https://github.com/ruby-oauth/oauth2 |
| Source | https://github.com/ruby-oauth/oauth2/tree/v2.0.21 |
| License | `MIT` |
| Funding | https://github.com/sponsors/pboling, https://issuehunt.io/u/pboling, https://ko-fi.com/pboling, https://liberapay.com/pboling/donate, https://opencollective.com/ruby-oauth, https://patreon.com/galtzo, https://polar.sh/pboling, https://thanks.dev/u/gh/pboling, https://tidelift.com/funding/github/rubygems/oauth2, https://www.buymeacoffee.com/pboling |
<!-- kettle-jem:metadata:end -->
