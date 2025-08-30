[![Galtzo FLOSS Logo by Aboling0, CC BY-SA 4.0][🖼️galtzo-i]][🖼️galtzo-discord] [![ruby-lang Logo, Yukihiro Matsumoto, Ruby Visual Identity Team, CC BY-SA 2.5][🖼️ruby-lang-i]][🖼️ruby-lang] [![oauth2 Logo by Chris Messina, CC BY-SA 3.0][🖼️oauth2-i]][🖼️oauth2]

[🖼️oauth2-i]: https://logos.galtzo.com/assets/images/oauth/oauth2/avatar-192px.svg
[🖼️oauth2]: https://github.com/ruby-oauth/oauth2
[🖼️ruby-lang-i]: https://logos.galtzo.com/assets/images/ruby-lang/avatar-192px.svg
[🖼️ruby-lang]: https://www.ruby-lang.org/
[🖼️galtzo-i]: https://logos.galtzo.com/assets/images/galtzo-floss/avatar-192px.svg
[🖼️galtzo-discord]: https://discord.gg/3qme4XHNKN

# 🔐 OAuth 2.0 Authorization Framework

⭐️ including OAuth 2.1 draft spec & OpenID Connect (OIDC)

[![Version][👽versioni]][👽version] [![GitHub tag (latest SemVer)][⛳️tag-img]][⛳️tag] [![License: MIT][📄license-img]][📄license-ref] [![Downloads Rank][👽dl-ranki]][👽dl-rank] [![Open Source Helpers][👽oss-helpi]][👽oss-help] [![Coveralls Test Coverage][🔑coveralls-img]][🔑coveralls] [![QLTY Test Coverage][🔑qlty-covi]][🔑qlty-cov] [![QLTY Maintainability][🔑qlty-mnti]][🔑qlty-mnt] [![CI Heads][🚎3-hd-wfi]][🚎3-hd-wf] [![CI Runtime Dependencies @ HEAD][🚎12-crh-wfi]][🚎12-crh-wf] [![CI Current][🚎11-c-wfi]][🚎11-c-wf] [![CI Truffle Ruby][🚎9-t-wfi]][🚎9-t-wf] [![CI JRuby][🚎10-j-wfi]][🚎10-j-wf] [![Deps Locked][🚎13-🔒️-wfi]][🚎13-🔒️-wf] [![Deps Unlocked][🚎14-🔓️-wfi]][🚎14-🔓️-wf] [![CI Supported][🚎6-s-wfi]][🚎6-s-wf] [![CI Legacy][🚎4-lg-wfi]][🚎4-lg-wf] [![CI Unsupported][🚎7-us-wfi]][🚎7-us-wf] [![CI Ancient][🚎1-an-wfi]][🚎1-an-wf] [![CI Caboose is an absolute WAGON][🚎13-cbs-wfi]][🚎13-cbs-wf] [![CI Test Coverage][🚎2-cov-wfi]][🚎2-cov-wf] [![CI Style][🚎5-st-wfi]][🚎5-st-wf] [![CodeQL][🖐codeQL-img]][🖐codeQL]

If ☝️ `ci_badges.map(&:color).detect { it != "green"}`  [let me know][🖼️galtzo-discord], as I may have missed the [discord notification][🖼️galtzo-discord].

---

OTOH, if `ci_badges.map(&:color).all? { it == "green"}` 👇️ send money so I can do more of this. FLOSS maintenance is now my full-time job.

[![OpenCollective Backers][🖇osc-backers-i]][🖇osc-backers] [![OpenCollective Sponsors][🖇osc-sponsors-i]][🖇osc-sponsors] [![Sponsor Me on Github][🖇sponsor-img]][🖇sponsor] [![Liberapay Goal Progress][⛳liberapay-img]][⛳liberapay] [![Donate on PayPal][🖇paypal-img]][🖇paypal] [![Buy me a coffee][🖇buyme-small-img]][🖇buyme] [![Donate on Polar][🖇polar-img]][🖇polar] [![Donate to my FLOSS or refugee efforts at ko-fi.com][🖇kofi-img]][🖇kofi] [![Donate to my FLOSS or refugee efforts using Patreon][🖇patreon-img]][🖇patreon]

## 🌻 Synopsis

OAuth 2.0 is the industry-standard protocol for authorization.
OAuth 2.0 focuses on client developer simplicity while providing specific authorization flows for web applications,
    desktop applications, mobile phones, and living room devices.
This is a RubyGem for implementing OAuth 2.0 clients (not servers) in Ruby applications.

### Quick Example

<details>
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
OAuth2::Client.new(
  "REDMOND_CLIENT_ID", # client_id
  "REDMOND_CLIENT_SECRET", # client_secret
  auth_scheme: :request_body, # Other modes are supported: :basic_auth, :tls_client_auth, :private_key_jwt
  token_url: "oauth2/token", # relative path, except with leading `/`, then absolute path
  site: "https://login.microsoftonline.com/REDMOND_REDACTED",
). # The base path for token_url when it is relative
  client_credentials. # There are many other types to choose from!
  get_token(resource: "REDMOND_RESOURCE_UUID")
```

NOTE: `header` - The content type specified in the `curl` is already the default!

</details>

### Upgrading Runtime Gem Dependencies

This project sits underneath a large portion of the authorization systems on the internet.
According to GitHub's project tracking, which I believe only reports on public projects,
[100,000+ projects](https://github.com/ruby-oauth/oauth2/network/dependents), and
[500+ packages](https://github.com/ruby-oauth/oauth2/network/dependents?dependent_type=PACKAGE) depend on this project.

That means it is painful for the Ruby community when this gem forces updates to its runtime dependencies.

As a result, great care, and a lot of time, have been invested to ensure this gem is working with all the
leading versions per each minor version of Ruby of all the runtime dependencies it can install with.

What does that mean specifically for the runtime dependencies?

We have 100% test coverage of lines and branches, and this test suite runs across a large matrix
covering the latest patch for each of the following minor versions:

| 🚚 _Amazing_ test matrix was brought to you by | 🔎 appraisal2 🔎                                                                     |
|------------------------------------------------|--------------------------------------------------------------------------------------|
| 👟 Check it out!                               | ✨ [github.com/appraisal-rb/appraisal2](https://github.com/appraisal-rb/appraisal2) ✨ |

* Operating Systems: Linux, MacOS, Windows
* MRI Ruby @ v2.3, v2.4, v2.5, v2.6, v2.7, v3.0, v3.1, v3.2, v3.3, v3.4, HEAD
  * NOTE: This gem will still install on ruby v2.2, but vanilla GitHub Actions no longer supports testing against it, so YMMV.
* JRuby @ v9.2, v9.3, v9.4, v10.0, HEAD
* TruffleRuby @ v23.1, v24.1, HEAD
* gem `faraday` @ v0, v1, v2, HEAD ⏩️ [lostisland/faraday](https://github.com/lostisland/faraday)
* gem `jwt` @ v1, v2, v3, HEAD ⏩️ [jwt/ruby-jwt](https://github.com/jwt/ruby-jwt)
* gem `logger` @ v1.2, v1.5, v1.7, HEAD ⏩️ [ruby/logger](https://github.com/ruby/logger)
* gem `multi_xml` @ v0.5, v0.6, v0.7, HEAD ⏩️ [sferik/multi_xml](https://github.com/sferik/multi_xml)
* gem `rack` @ v1.2, v1.6, v2, v3, HEAD ⏩️ [rack/rack](https://github.com/rack/rack)
* gem `snaky_hash` @ v2, HEAD ⏩️ [ruby-oauth/snaky_hash](https://gitlab.com/ruby-oauth/snaky_hash)
* gem `version_gem` @ v1, HEAD ⏩️ [ruby-oauth/version_gem](https://gitlab.com/ruby-oauth/version_gem)

The last two were extracted from this gem. They are part of the `ruby-oauth` org,
and are developed in tight collaboration with this gem.

Also, where reasonable, tested against the runtime dependencies of those dependencies:

* gem `hashie` @ v0, v1, v2, v3, v4, v5, HEAD ⏩️ [hashie/hashie](https://github.com/hashie/hashie)

#### You should upgrade this gem with confidence\*.

- This gem follows a _strict & correct_ (according to the maintainer of SemVer; [more info][sv-pub-api]) interpretation of SemVer.
  - Dropping support for **any** of the runtime dependency versions above will be a major version bump.
  - If you aren't on one of the minor versions above, make getting there a priority.
- You should upgrade the dependencies of this gem with confidence\*.
- Please do upgrade, and then, when it goes smooth as butter [please sponsor me][🖇sponsor].  Thanks!

[sv-pub-api]: #-is-platform-support-part-of-the-public-api

\* MIT license; The only guarantees I make are for [enterprise support](#enterprise-support).

<details>
  <summary>Standard Library Dependencies</summary>

The various versions of each are tested via the Ruby test matrix, along with whatever Ruby includes them.

* base64
* cgi
* json
* time
* logger (removed from stdlib in Ruby 3.5 so added as runtime dependency in v2.0.10)

If you use a gem version of a core Ruby library it should work fine!

</details>

If it seems like you are in the wrong place, you might try one of these:

* [OAuth 2.0 Spec][oauth2-spec]
* [doorkeeper gem][doorkeeper-gem] for OAuth 2.0 server/provider implementation.
* [oauth sibling gem][sibling-gem] for OAuth 1.0 implementations in Ruby.

[oauth2-spec]: https://oauth.net/2/
[sibling-gem]: https://gitlab.com/ruby-oauth/oauth
[doorkeeper-gem]: https://github.com/doorkeeper-gem/doorkeeper

## 💡 Info you can shake a stick at

| Tokens to Remember      | [![Gem name][⛳️name-img]][⛳️gem-name] [![Gem namespace][⛳️namespace-img]][⛳️gem-namespace]                                                                                                                                                                                                                     |
|-------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Works with JRuby        | ![JRuby 9.1 Compat][💎jruby-9.1i] ![JRuby 9.2 Compat][💎jruby-9.2i] ![JRuby 9.3 Compat][💎jruby-9.3i] <br/> [![JRuby 9.4 Compat][💎jruby-9.4i]][🚎10-j-wf] [![JRuby 10.0 Compat][💎jruby-c-i]][🚎11-c-wf] [![JRuby HEAD Compat][💎jruby-headi]][🚎3-hd-wf]                                                     |
| Works with Truffle Ruby | ![Truffle Ruby 22.3 Compat][💎truby-22.3i] ![Truffle Ruby 23.0 Compat][💎truby-23.0i] <br/> [![Truffle Ruby 23.1 Compat][💎truby-23.1i]][🚎9-t-wf] [![Truffle Ruby 24.1 Compat][💎truby-c-i]][🚎11-c-wf]                                                                                                       |
| Works with MRI Ruby 3   | [![Ruby 3.0 Compat][💎ruby-3.0i]][🚎4-lg-wf] [![Ruby 3.1 Compat][💎ruby-3.1i]][🚎6-s-wf] [![Ruby 3.2 Compat][💎ruby-3.2i]][🚎6-s-wf] [![Ruby 3.3 Compat][💎ruby-3.3i]][🚎6-s-wf] [![Ruby 3.4 Compat][💎ruby-c-i]][🚎11-c-wf] [![Ruby HEAD Compat][💎ruby-headi]][🚎3-hd-wf]                                    |
| Works with MRI Ruby 2   | ![Ruby 2.2 Compat][💎ruby-2.2i] <br/> [![Ruby 2.3 Compat][💎ruby-2.3i]][🚎1-an-wf] [![Ruby 2.4 Compat][💎ruby-2.4i]][🚎1-an-wf] [![Ruby 2.5 Compat][💎ruby-2.5i]][🚎1-an-wf] [![Ruby 2.6 Compat][💎ruby-2.6i]][🚎7-us-wf] [![Ruby 2.7 Compat][💎ruby-2.7i]][🚎7-us-wf]                                         |
| Source                  | [![Source on GitLab.com][📜src-gl-img]][📜src-gl] [![Source on CodeBerg.org][📜src-cb-img]][📜src-cb] [![Source on Github.com][📜src-gh-img]][📜src-gh] [![The best SHA: dQw4w9WgXcQ!][🧮kloc-img]][🧮kloc]                                                                                                    |
| Documentation           | [![Current release on RubyDoc.info][📜docs-cr-rd-img]][🚎yard-current] [![YARD on Galtzo.com][📜docs-head-rd-img]][🚎yard-head] [![Maintainer Blog][🚂maint-blog-img]][🚂maint-blog] [![Wiki][📜wiki-img]][📜wiki]                                                                                             |
| Compliance              | [![License: MIT][📄license-img]][📄license-ref] [![📄ilo-declaration-img]][📄ilo-declaration] [![Security Policy][🔐security-img]][🔐security] [![Contributor Covenant 2.1][🪇conduct-img]][🪇conduct] [![SemVer 2.0.0][📌semver-img]][📌semver]                                                               |
| Style                   | [![Enforced Code Style Linter][💎rlts-img]][💎rlts] [![Keep-A-Changelog 1.0.0][📗keep-changelog-img]][📗keep-changelog] [![Gitmoji Commits][📌gitmoji-img]][📌gitmoji] [![Compatibility appraised by: appraisal2][💎appraisal2-img]][💎appraisal2]                                                             |
| Support                 | [![Live Chat on Discord][✉️discord-invite-img-ftb]][✉️discord-invite] [![Get help from me on Upwork][👨🏼‍🏫expsup-upwork-img]][👨🏼‍🏫expsup-upwork] [![Get help from me on Codementor][👨🏼‍🏫expsup-codementor-img]][👨🏼‍🏫expsup-codementor]                                                              |
| Maintainer 🎖️          | [![Follow Me on LinkedIn][💖🖇linkedin-img]][💖🖇linkedin] [![Follow Me on Ruby.Social][💖🐘ruby-mast-img]][💖🐘ruby-mast] [![Follow Me on Bluesky][💖🦋bluesky-img]][💖🦋bluesky] [![Contact Maintainer][🚂maint-contact-img]][🚂maint-contact] [![My technical writing][💖💁🏼‍♂️devto-img]][💖💁🏼‍♂️devto] |
| `...` 💖                | [![Find Me on WellFound:][💖✌️wellfound-img]][💖✌️wellfound] [![Find Me on CrunchBase][💖💲crunchbase-img]][💖💲crunchbase] [![My LinkTree][💖🌳linktree-img]][💖🌳linktree] [![More About Me][💖💁🏼‍♂️aboutme-img]][💖💁🏼‍♂️aboutme] [🧊][💖🧊berg] [🐙][💖🐙hub]  [🛖][💖🛖hut] [🧪][💖🧪lab]              |

### Compatibility

Compatible with Ruby 2.3+, and concordant releases of JRuby, and TruffleRuby.

| 🚚 _Amazing_ test matrix was brought to you by | 🔎 appraisal2 🔎                                                                    |
|------------------------------------------------|-------------------------------------------------------------------------------------|
| 👟 Check it out!                               | ✨ [github.com/appraisal-rb/appraisal2][💎appraisal2] ✨ |

### Federated DVCS

<details>
  <summary>Find this repo on other forges (Coming soon!)</summary>

| Federated [DVCS][💎d-in-dvcs] Repository        | Status                                                                | Issues                    | PRs                      | Wiki                      | CI                       | Discussions                  |
|-------------------------------------------------|-----------------------------------------------------------------------|---------------------------|--------------------------|---------------------------|--------------------------|------------------------------|
| 🧪 [ruby-oauth/oauth2 on GitLab][📜src-gl]   | The Truth                                                             | [💚][🤝gl-issues]         | [💚][🤝gl-pulls]         | [💚][📜wiki]              | 🏀 Tiny Matrix           | ➖                            |
| 🧊 [ruby-oauth/oauth2 on CodeBerg][📜src-cb] | An Ethical Mirror ([Donate][🤝cb-donate])                             | [💚][🤝cb-issues]         | [💚][🤝cb-pulls]         | ➖                         | ⭕️ No Matrix             | ➖                            |
| 🐙 [ruby-oauth/oauth2 on GitHub][📜src-gh]   | Another Mirror                                                        | [💚][🤝gh-issues]         | [💚][🤝gh-pulls]         | ➖                         | 💯 Full Matrix           | [💚][gh-discussions]         |
| 🤼 [OAuth Ruby Google Group][⛳gg-discussions] | "Active"                                                          | ➖                         | ➖                        | ➖                         | ➖                        | [💚][⛳gg-discussions]        |
| 🎮️ [Discord Server][✉️discord-invite]          | [![Live Chat on Discord][✉️discord-invite-img-ftb]][✉️discord-invite] | [Let's][✉️discord-invite] | [talk][✉️discord-invite] | [about][✉️discord-invite] | [this][✉️discord-invite] | [library!][✉️discord-invite] |

</details>

[gh-discussions]: https://github.com/ruby-oauth/oauth2/discussions

### Enterprise Support [![Tidelift](https://tidelift.com/badges/package/rubygems/oauth2)](https://tidelift.com/subscription/pkg/rubygems-oauth2?utm_source=rubygems-oauth2&utm_medium=referral&utm_campaign=readme)

<details>
  <summary>Need enterprise-level guarantees?</summary>

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

### 🔒 Secure Installation

<details>
  <summary>For Medium or High Security Installations</summary>

This gem is cryptographically signed, and has verifiable [SHA-256 and SHA-512][💎SHA_checksums] checksums by
[stone_checksums][💎stone_checksums]. Be sure the gem you install hasn’t been tampered with
by following the instructions below.

Add my public key (if you haven’t already, expires 2045-04-29) as a trusted certificate:

```console
gem cert --add <(curl -Ls https://raw.github.com/galtzo-floss/certs/main/pboling.pem)
```

You only need to do that once.  Then proceed to install with:

```console
gem install oauth2 -P MediumSecurity
```

The `MediumSecurity` trust profile will verify signed gems, but allow the installation of unsigned dependencies.

This is necessary because not all of `oauth2`’s dependencies are signed, so we cannot use `HighSecurity`.

If you want to up your security game full-time:

```console
bundle config set --global trust-policy MediumSecurity
```

NOTE: Be prepared to track down certs for signed gems and add them the same way you added mine.

</details>

## OAuth2 for Enterprise

Available as part of the Tidelift Subscription.

The maintainers of this and thousands of other packages are working with Tidelift to deliver commercial support and maintenance for the open source packages you use to build your applications. Save time, reduce risk, and improve code health, while paying the maintainers of the exact packages you use. [Learn more.][tidelift-ref]

[tidelift-ref]: https://tidelift.com/subscription/pkg/rubygems-oauth2?utm_source=rubygems-oauth2&utm_medium=referral&utm_campaign=enterprise

## Security contact information

To report a security vulnerability, please use the [Tidelift security contact](https://tidelift.com/security).
Tidelift will coordinate the fix and disclosure.

For more see [SECURITY.md][🔐security].

## What is new for v2.0?

- Works with Ruby versions >= 2.2
- Drop support for the expired MAC Draft (all versions)
- Support IETF rfc7515 JSON Web Signature - JWS (since v2.0.12)
    - Support JWT `kid` for key discovery and management
- Support IETF rfc7523 JWT Bearer Tokens (since v2.0.0)
- Support IETF rfc7231 Relative Location in Redirect (since v2.0.0)
- Support IETF rfc6749 Don't set oauth params when nil (since v2.0.0)
- Support IETF rfc7009 Token Revocation (since v2.0.10, updated in v2.0.13 to support revocation via URL-encoded parameters)
- Support [OIDC 1.0 Private Key JWT](https://openid.net/specs/openid-connect-core-1_0.html#ClientAuthentication); based on the OAuth JWT assertion specification [(RFC 7523)](https://tools.ietf.org/html/rfc7523)
- Support new formats, including from [jsonapi.org](http://jsonapi.org/format/): `application/vdn.api+json`, `application/vnd.collection+json`, `application/hal+json`, `application/problem+json`
- Adds option to `OAuth2::Client#get_token`:
    - `:access_token_class` (`AccessToken`); user specified class to use for all calls to `get_token`
- Adds option to `OAuth2::AccessToken#initialize`:
    - `:expires_latency` (`nil`); number of seconds by which AccessToken validity will be reduced to offset latency
- By default, keys are transformed to snake case.
    - Original keys will still work as previously, in most scenarios, thanks to [snaky_hash][snaky_hash] gem.
    - However, this is a _breaking_ change if you rely on `response.parsed.to_h` to retain the original case, and the original wasn't snake case, as the keys in the result will be snake case.
    - As of version 2.0.4 you can turn key transformation off with the `snaky: false` option.
- By default, the `:auth_scheme` is now `:basic_auth` (instead of `:request_body`)
    - Third-party strategies and gems may need to be updated if a provider was requiring client id/secret in the request body
- [... A lot more](https://gitlab.com/ruby-oauth/oauth2/-/blob/main/CHANGELOG.md#200-2022-06-21-tag)

[snaky_hash]: https://gitlab.com/ruby-oauth/snaky_hash

## Compatibility

Targeted ruby compatibility is non-EOL versions of Ruby, currently 3.2, 3.3, and 3.4.
Compatibility is further distinguished as "Best Effort Support" or "Incidental Support" for older versions of Ruby.
This gem will install on Ruby versions >= v2.2 for 2.x releases.
See `1-4-stable` branch for older rubies.

<details>
  <summary>Ruby Engine Compatibility Policy</summary>

This gem is tested against MRI, JRuby, and Truffleruby.
Each of those has varying versions that target a specific version of MRI Ruby.
This gem should work in the just-listed Ruby engines according to the targeted MRI compatibility in the table below.
If you would like to add support for additional engines,
see [gemfiles/README.md](gemfiles/README.md), then submit a PR to the correct maintenance branch as according to the table below.
</details>

<details>
  <summary>Ruby Version Compatibility Policy</summary>

If something doesn't work on one of these interpreters, it's a bug.

This library may inadvertently work (or seem to work) on other Ruby
implementations, however support will only be provided for the versions listed
above.

If you would like this library to support another Ruby version, you may
volunteer to be a maintainer. Being a maintainer entails making sure all tests
run and pass on that implementation. When something breaks on your
implementation, you will be responsible for providing patches in a timely
fashion. If critical issues for a particular implementation exist at the time
of a major release, support for that Ruby version may be dropped.
</details>

|     | Ruby OAuth2 Version | Maintenance Branch | Targeted Support     | Best Effort Support     | Incidental Support           |
|:----|---------------------|--------------------|----------------------|-------------------------|------------------------------|
| 1️⃣ | 2.0.x               | `main`             | 3.2, 3.3, 3.4        | 2.5, 2.6, 2.7, 3.0, 3.1 | 2.2, 2.3, 2.4                |
| 2️⃣ | 1.4.x               | `1-4-stable`       | 3.2, 3.3, 3.4        | 2.5, 2.6, 2.7, 3.0, 3.1 | 1.9, 2.0, 2.1, 2.2, 2.3, 2.4 |
| 3️⃣ | older               | N/A                | Best of luck to you! | Please upgrade!         |                              |

NOTE: The 1.4 series will only receive critical security updates.
See [SECURITY.md][🔐security].

## ⚙️ Configuration

You can turn on additional warnings.

```ruby
OAuth2.configure do |config|
  # Turn on a warning like:
  #   OAuth2::AccessToken.from_hash: `hash` contained more than one 'token' key
  config.silence_extra_tokens_warning = false # default: true
  # Set to true if you want to also show warnings about no tokens
  config.silence_no_tokens_warning = false # default: true,
end
```

The "extra tokens" problem comes from ambiguity in the spec about which token is the right token.
Some OAuth 2.0 standards legitimately have multiple tokens.
You may need to subclass `OAuth2::AccessToken`, or write your own custom alternative to it, and pass it in.
Specify your custom class with the `access_token_class` option.

If you only need one token you can, as of v2.0.10,
specify the exact token name you want to extract via the `OAuth2::AccessToken` using
the `token_name` option.

You'll likely need to do some source diving.
This gem has 100% test coverage for lines and branches, so the specs are a great place to look for ideas.
If you have time and energy please contribute to the documentation!

## 🔧 Basic Usage

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

In above example, the default Authorization URL is `oauth/authorize` and default Access Token URL is `oauth/token`, and, as they are missing a leading `/`, both are relative.

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
  token_url: "/stirrups/access_token",
)
# => #<OAuth2::Client:0x00000001204c8288 @id="client_id", @secret="client_sec...
client.auth_code.authorize_url(redirect_uri: "http://localhost:8080/oauth2/callback")
# => "https://example.org/jaunty/authorize/?client_id=client_id&redirect_uri=http%3A%2F%2Flocalhost%3A8080%2Foauth2%2Fcallback&response_type=code"
client.class.name
# => OAuth2::Client
```

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
See [response_spec.rb](https://github.com/ruby-oauth/oauth2/blob/main/spec/oauth2/response_spec.rb) if you need to study the hacks for older Rubies.

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

See [response_spec.rb](https://github.com/ruby-oauth/oauth2/blob/main/spec/oauth2/response_spec.rb), or the [ruby-oauth/snaky_hash](https://gitlab.com/ruby-oauth/snaky_hash) gem for more ideas.

#### What if I hate snakes and/or indifference?

```ruby
response = access.get("/api/resource", params: {"query_foo" => "bar"}, snaky: false)
JSON.parse(response.body)         # => {"accessToken"=>"aaaaaaaa", "additionalData"=>"additional"}
response.parsed                   # => {"accessToken"=>"aaaaaaaa", "additionalData"=>"additional"}
response.parsed["accessToken"]    # => "aaaaaaaa"
response.parsed["additionalData"] # => "additional"
response.parsed.class.name        # => Hash (just, regular old Hash)
```

<details>
  <summary>Debugging & Logging</summary>

Set an environment variable as per usual (e.g. with [dotenv](https://github.com/bkeepers/dotenv)).

```ruby
# will log both request and response, including bodies
ENV["OAUTH_DEBUG"] = "true"
```

By default, debug output will go to `$stdout`. This can be overridden when
initializing your OAuth2::Client.

```ruby
require "oauth2"
client = OAuth2::Client.new(
  "client_id",
  "client_secret",
  site: "https://example.org",
  logger: Logger.new("example.log", "weekly"),
)
```
</details>

### OAuth2::Response

The `AccessToken` methods `#get`, `#post`, `#put` and `#delete` and the generic `#request`
will return an instance of the #OAuth2::Response class.

This instance contains a `#parsed` method that will parse the response body and
return a Hash-like [`SnakyHash::StringKeyed`](https://gitlab.com/ruby-oauth/snaky_hash/-/blob/main/lib/snaky_hash/string_keyed.rb) if the `Content-Type` is `application/x-www-form-urlencoded` or if
the body is a JSON object.  It will return an Array if the body is a JSON
array.  Otherwise, it will return the original body string.

The original response body, headers, and status can be accessed via their
respective methods.

### OAuth2::AccessToken

If you have an existing Access Token for a user, you can initialize an instance
using various class methods including the standard new, `from_hash` (if you have
a hash of the values), or `from_kvform` (if you have an
`application/x-www-form-urlencoded` encoded string of the values).

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

## 📘 Comprehensive Usage

### Common Flows (end-to-end)

- Authorization Code (server-side web app):

```ruby
require "oauth2"
client = OAuth2::Client.new(
  ENV["CLIENT_ID"],
  ENV["CLIENT_SECRET"],
  site: "https://provider.example.com",
  redirect_uri: "https://my.app.example.com/oauth/callback",
)

# Step 1: redirect user to consent
state = SecureRandom.hex(16)
auth_url = client.auth_code.authorize_url(scope: "openid profile email", state: state)
# redirect_to auth_url

# Step 2: handle the callback
# params[:code], params[:state]
raise "state mismatch" unless params[:state] == state
access = client.auth_code.get_token(params[:code])

# Step 3: call APIs
profile = access.get("/api/v1/me").parsed
```

- Client Credentials (machine-to-machine):

```ruby
client = OAuth2::Client.new(ENV["CLIENT_ID"], ENV["CLIENT_SECRET"], site: "https://provider.example.com")
access = client.client_credentials.get_token(audience: "https://api.example.com")
resp = access.get("/v1/things")
```

- Resource Owner Password (legacy; avoid when possible):

```ruby
access = client.password.get_token("jdoe", "s3cret", scope: "read")
```

### Refresh Tokens

When the server issues a refresh_token, you can refresh manually or implement an auto-refresh wrapper.

- Manual refresh:

```ruby
if access.expired?
  access = access.refresh
end
```

- Auto-refresh wrapper pattern:

```ruby
class AutoRefreshingToken
  def initialize(token_provider, store: nil)
    @token = token_provider
    @store = store # e.g., something that responds to read/write for token data
  end

  def with(&blk)
    tok = ensure_fresh!
    blk ? blk.call(tok) : tok
  rescue OAuth2::Error => e
    # If a 401 suggests token invalidation, try one refresh and retry once
    if e.response && e.response.status == 401 && @token.refresh_token
      @token = @token.refresh
      @store.write(@token.to_hash) if @store
      retry
    end
    raise
  end

private

  def ensure_fresh!
    if @token.expired? && @token.refresh_token
      @token = @token.refresh
      @store.write(@token.to_hash) if @store
    end
    @token
  end
end

# usage
keeper = AutoRefreshingToken.new(access)
keeper.with { |tok| tok.get("/v1/protected") }
```

Persist the token across processes using `AccessToken#to_hash` and `AccessToken.from_hash(client, hash)`.

### Token Revocation (RFC 7009)

You can revoke either the access token or the refresh token.

```ruby
# Revoke the current access token
access.revoke(token_type_hint: :access_token)

# Or explicitly revoke the refresh token (often also invalidates associated access tokens)
access.revoke(token_type_hint: :refresh_token)
```

### Client Configuration Tips

- Authentication schemes for the token request:

```ruby
OAuth2::Client.new(
  id,
  secret,
  site: "https://provider.example.com",
  auth_scheme: :basic_auth, # default. Alternatives: :request_body, :tls_client_auth, :private_key_jwt
)
```

- Faraday connection, timeouts, proxy, custom adapter/middleware:

```ruby
client = OAuth2::Client.new(
  id,
  secret,
  site: "https://provider.example.com",
  connection_opts: {
    request: {open_timeout: 5, timeout: 15},
    proxy: ENV["HTTPS_PROXY"],
    ssl: {verify: true},
  },
) do |faraday|
  faraday.request(:url_encoded)
  # faraday.response :logger, Logger.new($stdout) # see OAUTH_DEBUG below
  faraday.adapter(:net_http_persistent) # or any Faraday adapter you need
end
```

- Redirection: The library follows up to `max_redirects` (default 5). You can override per-client via `options[:max_redirects]`.

### Handling Responses and Errors

- Parsing:

```ruby
resp = access.get("/v1/thing")
resp.status     # Integer
resp.headers    # Hash
resp.body       # String
resp.parsed     # SnakyHash::StringKeyed or Array when JSON array
```

- Error handling:

```ruby
begin
  access.get("/v1/forbidden")
rescue OAuth2::Error => e
  e.code         # OAuth2 error code (when present)
  e.description  # OAuth2 error description (when present)
  e.response     # OAuth2::Response (full access to status/headers/body)
end
```

- Disable raising on 4xx/5xx to inspect the response yourself:

```ruby
client = OAuth2::Client.new(id, secret, site: site, raise_errors: false)
res = client.request(:get, "/v1/maybe-errors")
if res.status == 429
  sleep res.headers["retry-after"].to_i
end
```

### Making Raw Token Requests

If a provider requires non-standard parameters or headers, you can call `client.get_token` directly:

```ruby
access = client.get_token({
  grant_type: "client_credentials",
  audience: "https://api.example.com",
  headers: {"X-Custom" => "value"},
  parse: :json, # override parsing
})
```

### OpenID Connect (OIDC) Notes

- If the token response includes an `id_token` (a JWT), this gem surfaces it but does not validate the signature. Use a JWT library and your provider's JWKs to verify it.
- For private_key_jwt client authentication, provide `auth_scheme: :private_key_jwt` and ensure your key configuration matches the provider requirements.

### Debugging

- Set environment variable `OAUTH_DEBUG=true` to enable verbose Faraday logging (uses the client-provided logger).
- To mirror a working curl request, ensure you set the same auth scheme, params, and content type. The Quick Example at the top shows a curl-to-ruby translation.

---

## 🦷 FLOSS Funding

While ruby-oauth tools are free software and will always be, the project would benefit immensely from some funding.
Raising a monthly budget of... "dollars" would make the project more sustainable.

We welcome both individual and corporate sponsors! We also offer a
wide array of funding channels to account for your preferences
(although currently [Open Collective][🖇osc] is our preferred funding platform).

**If you're working in a company that's making significant use of ruby-oauth tools we'd
appreciate it if you suggest to your company to become a ruby-oauth sponsor.**

You can support the development of ruby-oauth tools via
[GitHub Sponsors][🖇sponsor],
[Liberapay][⛳liberapay],
[PayPal][🖇paypal],
[Open Collective][🖇osc]
and [Tidelift][🏙️entsup-tidelift].

| 📍 NOTE                                                                                                                                                                                                              |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| If doing a sponsorship in the form of donation is problematic for your company <br/> from an accounting standpoint, we'd recommend the use of Tidelift, <br/> where you can get a support-like subscription instead. |

### Open Collective for Individuals

<!-- OPENCOLLECTIVE-INDIVIDUALS:START -->
No backers yet. Be the first!
<!-- OPENCOLLECTIVE-INDIVIDUALS:END -->

Support us with a monthly donation and help us continue our activities. [[Become a backer](https://opencollective.com/ruby-oauth#backer)]

### Open Collective for Organizations

<!-- OPENCOLLECTIVE-ORGANIZATIONS:START -->
No sponsors yet. Be the first!
<!-- OPENCOLLECTIVE-ORGANIZATIONS:END -->

Become a sponsor and get your logo on our README on GitHub with a link to your site. [[Become a sponsor](https://opencollective.com/ruby-oauth#sponsor)]

### Another way to support open-source

> How wonderful it is that nobody need wait a single moment before starting to improve the world.<br/>
>—Anne Frank

I’m driven by a passion to foster a thriving open-source community – a space where people can tackle complex problems, no matter how small.  Revitalizing libraries that have fallen into disrepair, and building new libraries focused on solving real-world challenges, are my passions — totaling 79 hours of FLOSS coding over just the past seven days, a pretty regular week for me.  I was recently affected by layoffs, and the tech jobs market is unwelcoming. I’m reaching out here because your support would significantly aid my efforts to provide for my family, and my farm (11 🐔 chickens, 2 🐶 dogs, 3 🐰 rabbits, 8 🐈‍ cats).

If you work at a company that uses my work, please encourage them to support me as a corporate sponsor. My work on gems you use might show up in `bundle fund`.

I’m developing a new library, [floss_funding][🖇floss-funding-gem], designed to empower open-source developers like myself to get paid for the work we do, in a sustainable way. Please give it a look.

**[Floss-Funding.dev][🖇floss-funding.dev]: 👉️ No network calls. 👉️ No tracking. 👉️ No oversight. 👉️ Minimal crypto hashing. 💡 Easily disabled nags**

[![OpenCollective Backers][🖇osc-backers-i]][🖇osc-backers] [![OpenCollective Sponsors][🖇osc-sponsors-i]][🖇osc-sponsors] [![Sponsor Me on Github][🖇sponsor-img]][🖇sponsor] [![Liberapay Goal Progress][⛳liberapay-img]][⛳liberapay] [![Donate on PayPal][🖇paypal-img]][🖇paypal] [![Buy me a coffee][🖇buyme-small-img]][🖇buyme] [![Donate on Polar][🖇polar-img]][🖇polar] [![Donate to my FLOSS or refugee efforts at ko-fi.com][🖇kofi-img]][🖇kofi] [![Donate to my FLOSS or refugee efforts using Patreon][🖇patreon-img]][🖇patreon]

## 🔐 Security

See [SECURITY.md][🔐security].

## 🤝 Contributing

If you need some ideas of where to help, you could work on adding more code coverage,
or if it is already 💯 (see [below](#code-coverage)) check [reek](REEK), [issues][🤝gh-issues], or [PRs][🤝gh-pulls],
or use the gem and think about how it could be better.

We [![Keep A Changelog][📗keep-changelog-img]][📗keep-changelog] so if you make changes, remember to update it.

See [CONTRIBUTING.md][🤝contributing] for more detailed instructions.

### 🚀 Release Instructions

See [CONTRIBUTING.md][🤝contributing].

### Code Coverage

[![Coveralls Test Coverage][🔑coveralls-img]][🔑coveralls]

[![QLTY Test Coverage][🔑qlty-covi]][🔑qlty-cov]

### 🪇 Code of Conduct

Everyone interacting with this project's codebases, issue trackers,
chat rooms and mailing lists agrees to follow the [![Contributor Covenant 2.1][🪇conduct-img]][🪇conduct].

## 🌈 Contributors

[![Contributors][🖐contributors-img]][🖐contributors]

Made with [contributors-img][🖐contrib-rocks].

Also see GitLab Contributors: [https://gitlab.com/ruby-oauth/oauth2/-/graphs/main][🚎contributors-gl]

<details>
    <summary>⭐️ Star History</summary>

<a href="https://star-history.com/#ruby-oauth/oauth2&Date">
 <picture>
   <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/svg?repos=ruby-oauth/oauth2&type=Date&theme=dark" />
   <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/svg?repos=ruby-oauth/oauth2&type=Date" />
   <img alt="Star History Chart" src="https://api.star-history.com/svg?repos=ruby-oauth/oauth2&type=Date" />
 </picture>
</a>

</details>

## 📌 Versioning

This Library adheres to [![Semantic Versioning 2.0.0][📌semver-img]][📌semver].
Violations of this scheme should be reported as bugs.
Specifically, if a minor or patch version is released that breaks backward compatibility,
a new version should be immediately released that restores compatibility.
Breaking changes to the public API will only be introduced with new major versions.

> dropping support for a platform is both obviously and objectively a breaking change <br/>
>—Jordan Harband ([@ljharb](https://github.com/ljharb), maintainer of SemVer) [in SemVer issue 716][📌semver-breaking]

I understand that policy doesn't work universally ("exceptions to every rule!"),
but it is the policy here.
As such, in many cases it is good to specify a dependency on this library using
the [Pessimistic Version Constraint][📌pvc] with two digits of precision.

For example:

```ruby
spec.add_dependency("oauth2", "~> 2.0")
```

<details>
<summary>📌 Is "Platform Support" part of the public API? More details inside.</summary>

SemVer should, IMO, but doesn't explicitly, say that dropping support for specific Platforms
is a *breaking change* to an API.
It is obvious to many, but not all, and since the spec is silent, the bike shedding is endless.

To get a better understanding of how SemVer is intended to work over a project's lifetime,
read this article from the creator of SemVer:

- ["Major Version Numbers are Not Sacred"][📌major-versions-not-sacred]

</details>

See [CHANGELOG.md][📌changelog] for a list of releases.

## 📄 License

The gem is available as open source under the terms of
the [MIT License][📄license] [![License: MIT][📄license-img]][📄license-ref].
See [LICENSE.txt][📄license] for the official [Copyright Notice][📄copyright-notice-explainer].

### © Copyright

<ul>
    <li>
        Copyright (c) 2017–2025 Peter H. Boling, of
        <a href="https://discord.gg/3qme4XHNKN">
            Galtzo.com
            <picture>
              <img src="https://logos.galtzo.com/assets/images/galtzo-floss/avatar-128px-blank.svg" alt="Galtzo.com Logo (Wordless) by Aboling0, CC BY-SA 4.0" width="24">
            </picture>
        </a>, and oauth2 contributors.
    </li>
    <li>
        Copyright (c) 2011-2013 Michael Bleigh and Intridea, Inc.
    </li>
</ul>

## 🤑 A request for help

Maintainers have teeth and need to pay their dentists.
After getting laid off in an RIF in March and filled with many dozens of rejections,
I'm now spending ~60+ hours a week building open source tools.
I'm hoping to be able to pay for my kids' health insurance this month,
so if you value the work I am doing, I need your support.
Please consider sponsoring me or the project.

To join the community or get help 👇️ Join the Discord.

[![Live Chat on Discord][✉️discord-invite-img-ftb]][✉️discord-invite]

To say "thanks for maintaining such a great tool" ☝️ Join the Discord or 👇️ send money.

[![Sponsor ruby-oauth/oauth2 on Open Source Collective][🖇osc-all-bottom-img]][🖇osc] 💌 [![Sponsor me on GitHub Sponsors][🖇sponsor-bottom-img]][🖇sponsor] 💌 [![Sponsor me on Liberapay][⛳liberapay-bottom-img]][⛳liberapay-img] 💌 [![Donate on PayPal][🖇paypal-bottom-img]][🖇paypal-img]

### Please give the project a star ⭐ ♥.

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
[🖇kofi-img]: https://img.shields.io/badge/ko--fi-✓-a51611.svg?style=flat
[🖇kofi]: https://ko-fi.com/O5O86SNP4
[🖇patreon-img]: https://img.shields.io/badge/patreon-donate-a51611.svg?style=flat
[🖇patreon]: https://patreon.com/galtzo
[🖇buyme-small-img]: https://img.shields.io/badge/buy_me_a_coffee-✓-a51611.svg?style=flat
[🖇buyme-img]: https://img.buymeacoffee.com/button-api/?text=Buy%20me%20a%20latte&emoji=&slug=pboling&button_colour=FFDD00&font_colour=000000&font_family=Cookie&outline_colour=000000&coffee_colour=ffffff
[🖇buyme]: https://www.buymeacoffee.com/pboling
[🖇paypal-img]: https://img.shields.io/badge/donate-paypal-a51611.svg?style=flat&logo=paypal
[🖇paypal-bottom-img]: https://img.shields.io/badge/donate-paypal-a51611.svg?style=for-the-badge&logo=paypal&color=0A0A0A
[🖇paypal]: https://www.paypal.com/paypalme/peterboling
[🖇floss-funding.dev]: https://floss-funding.dev
[🖇floss-funding-gem]: https://github.com/galtzo-floss/floss_funding
[✉️discord-invite]: https://discord.gg/3qme4XHNKN
[✉️discord-invite-img-ftb]: https://img.shields.io/discord/1373797679469170758?style=for-the-badge

[⛳gg-discussions]: https://groups.google.com/g/oauth-ruby
[⛳gg-discussions-img]: https://img.shields.io/badge/google-group-0093D0.svg?style=for-the-badge&logo=google&logoColor=orange

[✇bundle-group-pattern]: https://gist.github.com/pboling/4564780
[⛳️gem-namespace]: https://github.com/ruby-oauth/oauth2
[⛳️namespace-img]: https://img.shields.io/badge/namespace-OAuth2-3C2D2D.svg?style=square&logo=ruby&logoColor=white
[⛳️gem-name]: https://rubygems.org/gems/oauth2
[⛳️name-img]: https://img.shields.io/badge/name-oauth2-3C2D2D.svg?style=square&logo=rubygems&logoColor=red
[⛳️tag-img]: https://img.shields.io/github/tag/ruby-oauth/oauth2.svg
[⛳️tag]: http://github.com/ruby-oauth/oauth2/releases
[🚂maint-blog]: http://www.railsbling.com/tags/oauth2
[🚂maint-blog-img]: https://img.shields.io/badge/blog-railsbling-0093D0.svg?style=for-the-badge&logo=rubyonrails&logoColor=orange
[🚂maint-contact]: http://www.railsbling.com/contact
[🚂maint-contact-img]: https://img.shields.io/badge/Contact-Maintainer-0093D0.svg?style=flat&logo=rubyonrails&logoColor=red
[💖🖇linkedin]: http://www.linkedin.com/in/peterboling
[💖🖇linkedin-img]: https://img.shields.io/badge/PeterBoling-LinkedIn-0B66C2?style=flat&logo=newjapanprowrestling
[💖✌️wellfound]: https://wellfound.com/u/peter-boling/u/peter-boling
[💖✌️wellfound-img]: https://img.shields.io/badge/peter--boling-orange?style=flat&logo=wellfound
[💖💲crunchbase]: https://www.crunchbase.com/person/peter-boling
[💖💲crunchbase-img]: https://img.shields.io/badge/peter--boling-purple?style=flat&logo=crunchbase
[💖🐘ruby-mast]: https://ruby.social/@galtzo
[💖🐘ruby-mast-img]: https://img.shields.io/mastodon/follow/109447111526622197?domain=https%3A%2F%2Fruby.social&style=flat&logo=mastodon&label=Ruby%20%40galtzo
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
[📜src-gl]: https://gitlab.com/ruby-oauth/oauth2/
[📜src-cb-img]: https://img.shields.io/badge/CodeBerg-4893CC?style=for-the-badge&logo=CodeBerg&logoColor=blue
[📜src-cb]: https://codeberg.org/ruby-oauth/oauth2
[📜src-gh-img]: https://img.shields.io/badge/GitHub-238636?style=for-the-badge&logo=Github&logoColor=green
[📜src-gh]: https://github.com/ruby-oauth/oauth2
[📜docs-cr-rd-img]: https://img.shields.io/badge/RubyDoc-Current_Release-943CD2?style=for-the-badge&logo=readthedocs&logoColor=white
[📜docs-head-rd-img]: https://img.shields.io/badge/YARD_on_Galtzo.com-HEAD-943CD2?style=for-the-badge&logo=readthedocs&logoColor=white
[📜wiki]: https://gitlab.com/ruby-oauth/oauth2/-/wikis/home
[📜wiki-img]: https://img.shields.io/badge/wiki-examples-943CD2.svg?style=for-the-badge&logo=Wiki&logoColor=white
[👽dl-rank]: https://rubygems.org/gems/oauth2
[👽dl-ranki]: https://img.shields.io/gem/rd/oauth2.svg
[👽oss-help]: https://www.codetriage.com/ruby-oauth/oauth2
[👽oss-helpi]: https://www.codetriage.com/ruby-oauth/oauth2/badges/users.svg
[👽version]: https://rubygems.org/gems/oauth2
[👽versioni]: https://img.shields.io/gem/v/oauth2.svg
[🔑qlty-mnt]: https://qlty.sh/gh/ruby-oauth/projects/oauth2
[🔑qlty-mnti]: https://qlty.sh/gh/ruby-oauth/projects/oauth2/maintainability.svg
[🔑qlty-cov]: https://qlty.sh/gh/ruby-oauth/projects/oauth2/metrics/code?sort=coverageRating
[🔑qlty-covi]: https://qlty.sh/gh/ruby-oauth/projects/oauth2/coverage.svg
[🔑codecov]: https://codecov.io/gh/ruby-oauth/oauth2
[🔑codecovi]: https://codecov.io/gh/ruby-oauth/oauth2/graph/badge.svg
[🔑coveralls]: https://coveralls.io/github/ruby-oauth/oauth2?branch=main
[🔑coveralls-img]: https://coveralls.io/repos/github/ruby-oauth/oauth2/badge.svg?branch=main
[🖐codeQL]: https://github.com/ruby-oauth/oauth2/security/code-scanning
[🖐codeQL-img]: https://github.com/ruby-oauth/oauth2/actions/workflows/codeql-analysis.yml/badge.svg
[🚎1-an-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/ancient.yml
[🚎1-an-wfi]: https://github.com/ruby-oauth/oauth2/actions/workflows/ancient.yml/badge.svg
[🚎2-cov-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/coverage.yml
[🚎2-cov-wfi]: https://github.com/ruby-oauth/oauth2/actions/workflows/coverage.yml/badge.svg
[🚎3-hd-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/heads.yml
[🚎3-hd-wfi]: https://github.com/ruby-oauth/oauth2/actions/workflows/heads.yml/badge.svg
[🚎4-lg-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/legacy.yml
[🚎4-lg-wfi]: https://github.com/ruby-oauth/oauth2/actions/workflows/legacy.yml/badge.svg
[🚎5-st-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/style.yml
[🚎5-st-wfi]: https://github.com/ruby-oauth/oauth2/actions/workflows/style.yml/badge.svg
[🚎6-s-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/supported.yml
[🚎6-s-wfi]: https://github.com/ruby-oauth/oauth2/actions/workflows/supported.yml/badge.svg
[🚎7-us-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/unsupported.yml
[🚎7-us-wfi]: https://github.com/ruby-oauth/oauth2/actions/workflows/unsupported.yml/badge.svg
[🚎8-ho-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/hoary.yml
[🚎8-ho-wfi]: https://github.com/ruby-oauth/oauth2/actions/workflows/hoary.yml/badge.svg
[🚎9-t-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/truffle.yml
[🚎9-t-wfi]: https://github.com/ruby-oauth/oauth2/actions/workflows/truffle.yml/badge.svg
[🚎10-j-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/jruby.yml
[🚎10-j-wfi]: https://github.com/ruby-oauth/oauth2/actions/workflows/jruby.yml/badge.svg
[🚎11-c-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/current.yml
[🚎11-c-wfi]: https://github.com/ruby-oauth/oauth2/actions/workflows/current.yml/badge.svg
[🚎12-crh-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/current-runtime-heads.yml
[🚎12-crh-wfi]: https://github.com/ruby-oauth/oauth2/actions/workflows/current-runtime-heads.yml/badge.svg
[🚎13-cbs-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/caboose.yml
[🚎13-cbs-wfi]: https://github.com/ruby-oauth/oauth2/actions/workflows/caboose.yml/badge.svg
[🚎13-🔒️-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/locked_deps.yml
[🚎13-🔒️-wfi]: https://github.com/ruby-oauth/oauth2/actions/workflows/locked_deps.yml/badge.svg
[🚎14-🔓️-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/unlocked_deps.yml
[🚎14-🔓️-wfi]: https://github.com/ruby-oauth/oauth2/actions/workflows/unlocked_deps.yml/badge.svg
[💎ruby-2.2i]: https://img.shields.io/badge/Ruby-2.2_(%F0%9F%9A%ABCI)-AABBCC?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-2.3i]: https://img.shields.io/badge/Ruby-2.3-DF00CA?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-2.4i]: https://img.shields.io/badge/Ruby-2.4-DF00CA?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-2.5i]: https://img.shields.io/badge/Ruby-2.5-DF00CA?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-2.6i]: https://img.shields.io/badge/Ruby-2.6-DF00CA?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-2.7i]: https://img.shields.io/badge/Ruby-2.7-DF00CA?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-3.0i]: https://img.shields.io/badge/Ruby-3.0-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-3.1i]: https://img.shields.io/badge/Ruby-3.1-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-3.2i]: https://img.shields.io/badge/Ruby-3.2-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-3.3i]: https://img.shields.io/badge/Ruby-3.3-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-c-i]: https://img.shields.io/badge/Ruby-current-CC342D?style=for-the-badge&logo=ruby&logoColor=green
[💎ruby-headi]: https://img.shields.io/badge/Ruby-HEAD-CC342D?style=for-the-badge&logo=ruby&logoColor=blue
[💎truby-22.3i]: https://img.shields.io/badge/Truffle_Ruby-22.3_(%F0%9F%9A%ABCI)-AABBCC?style=for-the-badge&logo=ruby&logoColor=pink
[💎truby-23.0i]: https://img.shields.io/badge/Truffle_Ruby-23.0_(%F0%9F%9A%ABCI)-AABBCC?style=for-the-badge&logo=ruby&logoColor=pink
[💎truby-23.1i]: https://img.shields.io/badge/Truffle_Ruby-23.1-34BCB1?style=for-the-badge&logo=ruby&logoColor=pink
[💎truby-c-i]: https://img.shields.io/badge/Truffle_Ruby-current-34BCB1?style=for-the-badge&logo=ruby&logoColor=green
[💎truby-headi]: https://img.shields.io/badge/Truffle_Ruby-HEAD-34BCB1?style=for-the-badge&logo=ruby&logoColor=blue
[💎jruby-9.1i]: https://img.shields.io/badge/JRuby-9.1_(%F0%9F%9A%ABCI)-AABBCC?style=for-the-badge&logo=ruby&logoColor=red
[💎jruby-9.2i]: https://img.shields.io/badge/JRuby-9.2_(%F0%9F%9A%ABCI)-AABBCC?style=for-the-badge&logo=ruby&logoColor=red
[💎jruby-9.3i]: https://img.shields.io/badge/JRuby-9.3_(%F0%9F%9A%ABCI)-AABBCC?style=for-the-badge&logo=ruby&logoColor=red
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
[🤝contributing]: CONTRIBUTING.md
[🔑codecov-g]: https://codecov.io/gh/ruby-oauth/oauth2/graphs/tree.svg
[🖐contrib-rocks]: https://contrib.rocks
[🖐contributors]: https://github.com/ruby-oauth/oauth2/graphs/contributors
[🖐contributors-img]: https://contrib.rocks/image?repo=ruby-oauth/oauth2
[🚎contributors-gl]: https://gitlab.com/ruby-oauth/oauth2/-/graphs/main
[🪇conduct]: CODE_OF_CONDUCT.md
[🪇conduct-img]: https://img.shields.io/badge/Contributor_Covenant-2.1-259D6C.svg
[📌pvc]: http://guides.rubygems.org/patterns/#pessimistic-version-constraint
[📌semver]: https://semver.org/spec/v2.0.0.html
[📌semver-img]: https://img.shields.io/badge/semver-2.0.0-259D6C.svg?style=flat
[📌semver-breaking]: https://github.com/semver/semver/issues/716#issuecomment-869336139
[📌major-versions-not-sacred]: https://tom.preston-werner.com/2022/05/23/major-version-numbers-are-not-sacred.html
[📌changelog]: CHANGELOG.md
[📗keep-changelog]: https://keepachangelog.com/en/1.0.0/
[📗keep-changelog-img]: https://img.shields.io/badge/keep--a--changelog-1.0.0-34495e.svg?style=flat
[📌gitmoji]:https://gitmoji.dev
[📌gitmoji-img]:https://img.shields.io/badge/gitmoji_commits-%20😜%20😍-34495e.svg?style=flat-square
[🧮kloc]: https://www.youtube.com/watch?v=dQw4w9WgXcQ
[🧮kloc-img]: https://img.shields.io/badge/KLOC-0.520-FFDD67.svg?style=for-the-badge&logo=YouTube&logoColor=blue
[🔐security]: SECURITY.md
[🔐security-img]: https://img.shields.io/badge/security-policy-259D6C.svg?style=flat
[📄copyright-notice-explainer]: https://opensource.stackexchange.com/questions/5778/why-do-licenses-such-as-the-mit-license-specify-a-single-year
[📄license]: LICENSE.txt
[📄license-ref]: https://opensource.org/licenses/MIT
[📄license-img]: https://img.shields.io/badge/License-MIT-259D6C.svg
[📄ilo-declaration]: https://www.ilo.org/declaration/lang--en/index.htm
[📄ilo-declaration-img]: https://img.shields.io/badge/ILO_Fundamental_Principles-✓-259D6C.svg?style=flat
[🚎yard-current]: http://rubydoc.info/gems/oauth2
[🚎yard-head]: https://oauth2.galtzo.com
[💎stone_checksums]: https://github.com/galtzo-floss/stone_checksums
[💎SHA_checksums]: https://gitlab.com/ruby-oauth/oauth2/-/tree/main/checksums
[💎rlts]: https://github.com/rubocop-lts/rubocop-lts
[💎rlts-img]: https://img.shields.io/badge/code_style_%26_linting-rubocop--lts-34495e.svg?plastic&logo=ruby&logoColor=white
[💎appraisal2]: https://github.com/appraisal-rb/appraisal2
[💎appraisal2-img]: https://img.shields.io/badge/appraised_by-appraisal2-34495e.svg?plastic&logo=ruby&logoColor=white
[💎d-in-dvcs]: https://railsbling.com/posts/dvcs/put_the_d_in_dvcs/

<details>
  <summary>
    rel="me" Social Proofs
  </summary>

<a rel="me" alt="Follow me on Ruby.social" href="https://ruby.social/@galtzo"><img src="https://img.shields.io/mastodon/follow/109447111526622197?domain=https%3A%2F%2Fruby.social&style=social&label=Follow%20%40galtzo%20on%20Ruby.social"></a>
<a rel="me" alt="Follow me on FLOSS.social" href="https://floss.social/@galtzo"><img src="https://img.shields.io/mastodon/follow/110304921404405715?domain=https%3A%2F%2Ffloss.social&style=social&label=Follow%20%40galtzo%20on%20Floss.social"></a>

</details>


<details>
  <summary>Broken badges</summary>

[![Coverage Graph][🔑codecov-g]][🔑codecov]
[![CodeCov Test Coverage][🔑codecovi]][🔑codecov]

</details>
