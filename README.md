<a href="https://github.com/ruby-oauth"><img alt="ruby-oauth Logo by GitHub" src="https://github.com/ruby-oauth.png?size=192" width="14%" align="right"/></a>

# 🔐 OAuth2

[![Version][👽versioni]][👽version] [![Ruby Users Forum][✉️ruby-forum-top-img]][✉️ruby-forum] [![GitHub tag (latest SemVer)][⛳️tag-img]][⛳️tag] [![License: MIT][📄license-img]][📄license] [![Total downloads][👽dl-ranki]][👽dl-rank] [![CodeCov Test Coverage][🏀codecovi]][🏀codecov] [![Coveralls Test Coverage][🏀coveralls-img]][🏀coveralls] [![QLTY Test Coverage][🏀qlty-covi]][🏀qlty-cov] [![QLTY Maintainability][🏀qlty-mnti]][🏀qlty-mnt] [![CI Heads][🚎3-hd-wfi]][🚎3-hd-wf] [![CI Runtime Dependencies @ HEAD][🚎12-crh-wfi]][🚎12-crh-wf] [![CI Current][🚎11-c-wfi]][🚎11-c-wf] [![CI Truffle Ruby][🚎9-t-wfi]][🚎9-t-wf] [![CI JRuby][🚎10-j-wfi]][🚎10-j-wf] [![Deps Locked][🚎13-🔒️-wfi]][🚎13-🔒️-wf] [![Deps Unlocked][🚎14-🔓️-wfi]][🚎14-🔓️-wf] [![CI Test Coverage][🚎2-cov-wfi]][🚎2-cov-wf] [![CI Style][🚎5-st-wfi]][🚎5-st-wf] [![Apache SkyWalking Eyes License Compatibility Check][🚎15-🪪-wfi]][🚎15-🪪-wf]

`if ci_badges.map(&:color).detect { it != "green"}` ☝️ [let me know on Discord][✉️discord-invite] or [RubyForum][✉️ruby-forum], as I may have missed the notification.

---

`if ci_badges.map(&:color).all? { it == "green"}` 👇️ send money so I can do more of this. FLOSS maintenance is now my full-time job.

[![OpenCollective Backers][🖇osc-backers-i]][🖇osc-backers] [![OpenCollective Sponsors][🖇osc-sponsors-i]][🖇osc-sponsors] [![Sponsor Me on Github][🖇sponsor-img]][🖇sponsor] [![Liberapay Goal Progress][⛳liberapay-img]][⛳liberapay] [![Donate on PayPal][🖇paypal-img]][🖇paypal] [![Buy me a coffee][🖇buyme-small-img]][🖇buyme] [![Donate at ko-fi.com][🖇kofi-img]][🖇kofi]
<p><sub>Corporate sponsor: <a href="https://alpha-omega.dev"><img alt="Alpha-Omega" src="https://alpha-omega.dev/wp-content/uploads/sites/22/2023/05/logo.svg" height="24"/></a> <a href="#-floss-funding">Become a sponsor</a></sub></p>

<details markdown="1">
 <summary>👣 How will this project approach the September 2025 hostile takeover of RubyGems? 🚑️</summary>

I've summarized my thoughts in [this blog post](https://dev.to/galtzo/hostile-takeover-of-rubygems-my-thoughts-5hlo).

</details>

## 🌻 Synopsis <a href="https://discord.gg/3qme4XHNKN"><img alt="Galtzo FLOSS Logo by Aboling0, CC BY-SA 4.0" src="https://logos.galtzo.com/assets/images/galtzo-floss/avatar-128px.svg" width="8%" align="right"/></a> <a href="https://ruby-toolbox.com"><img alt="ruby-lang Logo, Yukihiro Matsumoto, Ruby Visual Identity Team, CC BY-SA 2.5" src="https://logos.galtzo.com/assets/images/ruby-lang/avatar-128px.svg" width="8%" align="right"/></a>

OAuth 2.0 is the industry-standard protocol for authorization.
OAuth 2.0 focuses on client developer simplicity while providing specific authorization flows for web applications,
desktop applications, mobile phones, and living room devices.
This is a RubyGem for implementing OAuth 2.0 clients (not servers) in Ruby applications.
See the sibling `oauth` gem for OAuth 1.0 implementations in Ruby.

⚠️⚠️⚠️ **_WARNING_**: You are viewing the `README` of the
[supported-only-for-critical-enterprise-security-issues](#oauth2-for-enterprise) `1-4-stable`
branch. Please do not use this, and instead upgrade to version 2! ⚠️⚠️⚠️

No further releases of 1.x series are planned!  [Version 2](https://gitlab.com/oauth-xx/oauth2/#what-is-new-for-v20) has *tons* of improvements!

If you must continue using 1.4.x please consider purchasing an open source security maintenance contract from [Tidelift][tidelift-ref].

---

* [OAuth 2.0 Spec][oauth2-spec]
* [OAuth 1.0 sibling gem][sibling-gem]

[oauth2-spec]: https://oauth.net/2/
[sibling-gem]: https://gitlab.com/oauth-xx/oauth

## 💡 Info you can shake a stick at

| Tokens to Remember | [![Gem name][⛳️name-img]][⛳️gem-name] [![Gem namespace][⛳️namespace-img]][⛳️gem-namespace] |
|-------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Works with JRuby | [![JRuby 9.2 Compat][💎jruby-9.2i]][🚎jruby-9.2-wf] [![JRuby 9.3 Compat][💎jruby-9.3i]][🚎jruby-9.3-wf] <br/> [![JRuby 9.4 Compat][💎jruby-9.4i]][🚎jruby-9.4-wf] [![JRuby 10.0 Compat][💎jruby-10.0i]][🚎jruby-10.0-wf] [![JRuby current Compat][💎jruby-c-i]][🚎10-j-wf] [![JRuby HEAD Compat][💎jruby-headi]][🚎3-hd-wf]|
| Works with Truffle Ruby | [![Truffle Ruby 22.3 Compat][💎truby-22.3i]][🚎truby-22.3-wf] [![Truffle Ruby 23.1 Compat][💎truby-23.1i]][🚎truby-23.1-wf] <br/> [![Truffle Ruby 24.2 Compat][💎truby-24.2i]][🚎truby-24.2-wf] [![Truffle Ruby 25.0 Compat][💎truby-25.0i]][🚎truby-25.0-wf] [![Truffle Ruby 33.0 Compat][💎truby-33.0i]][🚎truby-33.0-wf] [![Truffle Ruby current Compat][💎truby-c-i]][🚎9-t-wf]|
| Works with MRI Ruby 4 | [![Ruby current Compat][💎ruby-c-i]][🚎11-c-wf] [![Ruby HEAD Compat][💎ruby-headi]][🚎3-hd-wf]|
| Works with MRI Ruby 3 | [![Ruby 3.0 Compat][💎ruby-3.0i]][🚎ruby-3.0-wf] [![Ruby 3.1 Compat][💎ruby-3.1i]][🚎ruby-3.1-wf] [![Ruby 3.2 Compat][💎ruby-3.2i]][🚎ruby-3.2-wf] [![Ruby 3.3 Compat][💎ruby-3.3i]][🚎ruby-3.3-wf] [![Ruby 3.4 Compat][💎ruby-3.4i]][🚎ruby-3.4-wf]|
| Works with MRI Ruby 2 | ![Ruby 2.0 Compat][💎ruby-2.0i] ![Ruby 2.1 Compat][💎ruby-2.1i] ![Ruby 2.2 Compat][💎ruby-2.2i] ![Ruby 2.3 Compat][💎ruby-2.3i] <br/> [![Ruby 2.4 Compat][💎ruby-2.4i]][🚎ruby-2.4-wf] [![Ruby 2.5 Compat][💎ruby-2.5i]][🚎ruby-2.5-wf] [![Ruby 2.6 Compat][💎ruby-2.6i]][🚎ruby-2.6-wf] [![Ruby 2.7 Compat][💎ruby-2.7i]][🚎ruby-2.7-wf]|
| Works with MRI Ruby 1 | ![Ruby 1.9 Compat][💎ruby-1.9i]|
| Support & Community | [![Join Me on Daily.dev's RubyFriends][✉️ruby-friends-img]][✉️ruby-friends] [![Get help from RubyForum][✉️ruby-forum-img]][✉️ruby-forum] [![Live Chat on Discord][✉️discord-invite-img-ftb]][✉️discord-invite] [![Get help from me on Upwork][👨🏼‍🏫expsup-upwork-img]][👨🏼‍🏫expsup-upwork] [![Get help from me on Codementor][👨🏼‍🏫expsup-codementor-img]][👨🏼‍🏫expsup-codementor] |
| Source | [![Source on GitLab.com][📜src-gl-img]][📜src-gl] [![Source on CodeBerg.org][📜src-cb-img]][📜src-cb] [![Source on GitHub.com][📜src-gh-img]][📜src-gh] [![The best SHA: dQw4w9WgXcQ!][🧮kloc-img]][🧮kloc] |
| Documentation | [![Current release on RubyDoc.info][📜docs-cr-rd-img]][🚎yard-current] [![YARD on Galtzo.com][📜docs-head-rd-img]][🚎yard-head] [![Maintainer Blog][🚂maint-blog-img]][🚂maint-blog] [![GitLab Wiki][📜gl-wiki-img]][📜gl-wiki] [![GitHub Wiki][📜gh-wiki-img]][📜gh-wiki] |
| Compliance | [![License: MIT][📄license-img]][📄license] [![Apache license compatibility: Category A][📄license-compat-img]][📄license-compat] [![📄ilo-declaration-img]][📄ilo-declaration] [![Security Policy][🔐security-img]][🔐security] [![Contributor Covenant 2.1][🪇conduct-img]][🪇conduct] [![SemVer 2.0.0][📌semver-img]][📌semver] |
| Style | [![Enforced Code Style Linter][💎rlts-img]][💎rlts] [![Keep-A-Changelog 1.0.0][📗keep-changelog-img]][📗keep-changelog] [![Gitmoji Commits][📌gitmoji-img]][📌gitmoji] [![Compatibility appraised by: appraisal2][💎appraisal2-img]][💎appraisal2] |
| Maintainer 🎖️ | [![Follow Me on LinkedIn][💖🖇linkedin-img]][💖🖇linkedin] [![Follow Me on Ruby.Social][💖🐘ruby-mast-img]][💖🐘ruby-mast] [![Follow Me on Bluesky][💖🦋bluesky-img]][💖🦋bluesky] [![Contact Maintainer][🚂maint-contact-img]][🚂maint-contact] [![My technical writing][💖💁🏼‍♂️devto-img]][💖💁🏼‍♂️devto] |
| `...` 💖 | [![Find Me on WellFound:][💖✌️wellfound-img]][💖✌️wellfound] [![Find Me on CrunchBase][💖💲crunchbase-img]][💖💲crunchbase] [![My LinkTree][💖🌳linktree-img]][💖🌳linktree] [![More About Me][💖💁🏼‍♂️aboutme-img]][💖💁🏼‍♂️aboutme] [🧊][💖🧊berg] [🐙][💖🐙hub] [🛖][💖🛖hut] [🧪][💖🧪lab] |

### Compatibility

Compatible with MRI Ruby 1.9.0+, JRuby, and TruffleRuby.
CI workflows and Appraisals are generated for MRI Ruby 2.4+.
This test floor is configured by `ruby.test_minimum` in `.kettle-jem.yml` and
may be higher than the gem's runtime compatibility floor when legacy Rubies are
not practical for the current toolchain.

<a href="https://github.com/kettle-dev"><img alt="kettle-dev Logo by Aboling0, CC BY-SA 4.0" src="https://logos.galtzo.com/assets/images/kettle-dev/avatar-128px.svg" width="14%" align="right"/></a>

The _amazing_ test matrix is powered by the kettle-dev stack.

<details markdown="1">
<summary>How kettle-dev manages complexity in tests</summary>

| Gem | Source | Role | Total downloads |
|-----|--------|------|---------------------|
| [appraisal2](https://clickgems.clickhouse.com/dashboard/appraisal2) | [GitHub](https://github.com/appraisal-rb/appraisal2) | multi-dependency Appraisal matrix generation | [![Total downloads for appraisal2](https://img.shields.io/gem/dt/appraisal2.svg?style=flat-square)](https://clickgems.clickhouse.com/dashboard/appraisal2) |
| [appraisal2-rubocop](https://clickgems.clickhouse.com/dashboard/appraisal2-rubocop) | [GitHub](https://github.com/appraisal-rb/appraisal2-rubocop) | RuboCop Appraisal generator integration | [![Total downloads for appraisal2-rubocop](https://img.shields.io/gem/dt/appraisal2-rubocop.svg?style=flat-square)](https://clickgems.clickhouse.com/dashboard/appraisal2-rubocop) |
| [kettle-dev](https://clickgems.clickhouse.com/dashboard/kettle-dev) | [GitHub](https://github.com/kettle-dev/kettle-dev) | development, release, and CI workflow tooling | [![Total downloads for kettle-dev](https://img.shields.io/gem/dt/kettle-dev.svg?style=flat-square)](https://clickgems.clickhouse.com/dashboard/kettle-dev) |
| [kettle-jem](https://clickgems.clickhouse.com/dashboard/kettle-jem) | [GitHub](https://github.com/kettle-dev/kettle-jem) | Appraisals & CI workflow templates | [![Total downloads for kettle-jem](https://img.shields.io/gem/dt/kettle-jem.svg?style=flat-square)](https://clickgems.clickhouse.com/dashboard/kettle-jem) |
| [kettle-soup-cover](https://clickgems.clickhouse.com/dashboard/kettle-soup-cover) | [GitHub](https://github.com/kettle-dev/kettle-soup-cover) | SimpleCov coverage policy and reporting | [![Total downloads for kettle-soup-cover](https://img.shields.io/gem/dt/kettle-soup-cover.svg?style=flat-square)](https://clickgems.clickhouse.com/dashboard/kettle-soup-cover) |
| [kettle-test](https://clickgems.clickhouse.com/dashboard/kettle-test) | [GitHub](https://github.com/kettle-dev/kettle-test) | standard test runner and coverage harness | [![Total downloads for kettle-test](https://img.shields.io/gem/dt/kettle-test.svg?style=flat-square)](https://clickgems.clickhouse.com/dashboard/kettle-test) |
| [rubocop-lts](https://clickgems.clickhouse.com/dashboard/rubocop-lts) | [GitHub](https://github.com/rubocop-lts/rubocop-lts) | Ruby-version-aware linting | [![Total downloads for rubocop-lts](https://img.shields.io/gem/dt/rubocop-lts.svg?style=flat-square)](https://clickgems.clickhouse.com/dashboard/rubocop-lts) |
| [turbo_tests2](https://clickgems.clickhouse.com/dashboard/turbo_tests2) | [GitHub](https://github.com/galtzo-floss/turbo_tests2) | parallel test execution | [![Total downloads for turbo_tests2](https://img.shields.io/gem/dt/turbo_tests2.svg?style=flat-square)](https://clickgems.clickhouse.com/dashboard/turbo_tests2) |

</details>

## Usage Examples

```ruby
require "oauth2"
client = OAuth2::Client.new("client_id", "client_secret", :site => "https://example.org")

client.auth_code.authorize_url(:redirect_uri => "http://localhost:8080/oauth2/callback")
# => "https://example.org/oauth/authorization?response_type=code&client_id=client_id&redirect_uri=http://localhost:8080/oauth2/callback"

token = client.auth_code.get_token("authorization_code_value", :redirect_uri => "http://localhost:8080/oauth2/callback", :headers => {"Authorization" => "Basic some_password"})
response = token.get("/api/resource", :params => {"query_foo" => "bar"})
response.class.name
# => OAuth2::Response
```

<details>
  <summary>Debugging</summary>

Set an environment variable, however you would [normally do that](https://github.com/bkeepers/dotenv).

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
  :site => "https://example.org",
  :logger => Logger.new("example.log", "weekly")
)
```
</details>

## OAuth2::Response

The `AccessToken` methods `#get`, `#post`, `#put` and `#delete` and the generic `#request`
will return an instance of the #OAuth2::Response class.

This instance contains a `#parsed` method that will parse the response body and
return a Hash if the `Content-Type` is `application/x-www-form-urlencoded` or if
the body is a JSON object.  It will return an Array if the body is a JSON
array.  Otherwise, it will return the original body string.

The original response body, headers, and status can be accessed via their
respective methods.

## OAuth2::AccessToken

If you have an existing Access Token for a user, you can initialize an instance
using various class methods including the standard new, `from_hash` (if you have
a hash of the values), or `from_kvform` (if you have an
`application/x-www-form-urlencoded` encoded string of the values).

## OAuth2::Error

On 400+ status code responses, an `OAuth2::Error` will be raised.  If it is a
standard OAuth2 error response, the body will be parsed and `#code` and `#description` will contain the values provided from the error and
`error_description` parameters.  The `#response` property of `OAuth2::Error` will
always contain the `OAuth2::Response` instance.

If you do not want an error to be raised, you may use `:raise_errors => false`
option on initialization of the client.  In this case the `OAuth2::Response`
instance will be returned as usual and on 400+ status code responses, the
Response instance will contain the `OAuth2::Error` instance.

## Authorization Grants

Currently the Authorization Code, Implicit, Resource Owner Password Credentials, Client Credentials, and Assertion
authentication grant types have helper strategy classes that simplify client
use. They are available via the `#auth_code`, `#implicit`, `#password`, `#client_credentials`, and `#assertion` methods respectively.

```ruby
auth_url = client.auth_code.authorize_url(:redirect_uri => "http://localhost:8080/oauth/callback")
token = client.auth_code.get_token("code_value", :redirect_uri => "http://localhost:8080/oauth/callback")

auth_url = client.implicit.authorize_url(:redirect_uri => "http://localhost:8080/oauth/callback")
# get the token params in the callback and
token = OAuth2::AccessToken.from_kvform(client, query_string)

token = client.password.get_token("username", "password")

token = client.client_credentials.get_token

token = client.assertion.get_token(assertion_params)
```

If you want to specify additional headers to be sent out with the
request, add a 'headers' hash under 'params':

```ruby
token = client.auth_code.get_token("code_value", :redirect_uri => "http://localhost:8080/oauth/callback", :headers => {"Some" => "Header"})
```

You can always use the `#request` method on the `OAuth2::Client` instance to make
requests for tokens for any Authentication grant type.

### Federated DVCS

<details markdown="1">
 <summary>Find this repo on federated forges (Coming soon!)</summary>

| Federated [DVCS][💎d-in-dvcs] Repository | Status | Issues | PRs | Wiki | CI |
|-------------------------------------------------|-------------------------------------------|-------------------|------------------|-----------------|----------------|
| 🧪 [ruby-oauth/oauth2 on GitLab][📜src-gl] | The Truth | [💚][🤝gl-issues] | [💚][🤝gl-pulls] | [💚][📜gl-wiki] | 🐭 Tiny Matrix |
| 🧊 [ruby-oauth/oauth2 on CodeBerg][📜src-cb] | An Ethical Mirror ([Donate][🤝cb-donate]) | [💚][🤝cb-issues] | [💚][🤝cb-pulls] | ➖ | ⭕️ No Matrix |
| 🐙 [ruby-oauth/oauth2 on GitHub][📜src-gh] | Another Mirror | [💚][🤝gh-issues] | [💚][🤝gh-pulls] | [💚][📜gh-wiki] | 💯 Full Matrix |

</details>

### Enterprise Support

For enterprise support from the maintainer, use [Upwork][👨🏼‍🏫expsup-upwork] or [CodeMentor][👨🏼‍🏫expsup-codementor].

Other support channels:

- [![Ruby Users Forum][✉️ruby-forum-img]][✉️ruby-forum]
- [![Live Chat on Discord][✉️discord-invite-img-ftb]][✉️discord-invite]

### Federated DVCS

<details markdown="1">
 <summary>Find this repo on federated forges (Coming soon!)</summary>

| Federated [DVCS][💎d-in-dvcs] Repository | Status | Issues | PRs | Wiki | CI |
|-------------------------------------------------|-------------------------------------------|-------------------|------------------|-----------------|----------------|
| 🧪 [ruby-oauth/oauth2 on GitLab][📜src-gl] | The Truth | [💚][🤝gl-issues] | [💚][🤝gl-pulls] | [💚][📜gl-wiki] | 🐭 Tiny Matrix |
| 🧊 [ruby-oauth/oauth2 on CodeBerg][📜src-cb] | An Ethical Mirror ([Donate][🤝cb-donate]) | [💚][🤝cb-issues] | [💚][🤝cb-pulls] | ➖ | ⭕️ No Matrix |
| 🐙 [ruby-oauth/oauth2 on GitHub][📜src-gh] | Another Mirror | [💚][🤝gh-issues] | [💚][🤝gh-pulls] | [💚][📜gh-wiki] | 💯 Full Matrix |

</details>

### Enterprise Support

For enterprise support from the maintainer, use [Upwork][👨🏼‍🏫expsup-upwork] or [CodeMentor][👨🏼‍🏫expsup-codementor].

Other support channels:

- [![Ruby Users Forum][✉️ruby-forum-img]][✉️ruby-forum]
- [![Live Chat on Discord][✉️discord-invite-img-ftb]][✉️discord-invite]

### Federated DVCS

<details markdown="1">
 <summary>Find this repo on federated forges (Coming soon!)</summary>

| Federated [DVCS][💎d-in-dvcs] Repository | Status | Issues | PRs | Wiki | CI |
|-------------------------------------------------|-------------------------------------------|-------------------|------------------|-----------------|----------------|
| 🧪 [ruby-oauth/oauth2 on GitLab][📜src-gl] | The Truth | [💚][🤝gl-issues] | [💚][🤝gl-pulls] | [💚][📜gl-wiki] | 🐭 Tiny Matrix |
| 🧊 [ruby-oauth/oauth2 on CodeBerg][📜src-cb] | An Ethical Mirror ([Donate][🤝cb-donate]) | [💚][🤝cb-issues] | [💚][🤝cb-pulls] | ➖ | ⭕️ No Matrix |
| 🐙 [ruby-oauth/oauth2 on GitHub][📜src-gh] | Another Mirror | [💚][🤝gh-issues] | [💚][🤝gh-pulls] | [💚][📜gh-wiki] | 💯 Full Matrix |

</details>

### Enterprise Support

For enterprise support from the maintainer, use [Upwork][👨🏼‍🏫expsup-upwork] or [CodeMentor][👨🏼‍🏫expsup-codementor].

Other support channels:

- [![Ruby Users Forum][✉️ruby-forum-img]][✉️ruby-forum]
- [![Live Chat on Discord][✉️discord-invite-img-ftb]][✉️discord-invite]

### Runtime and Platform Support

Support tiers describe what this project's CI actually exercises, not what may
work in an untested environment:

- **Parallel support**: CI runs the test suite with multiple workers available.
- **Unsupported**: the engine/platform combination is not covered by CI and is
 not a project compatibility claim.

| Ruby engine/version | Linux | macOS | Windows | Notes |
|---------------------|-------|-------|---------|-------|
| MRI 3.1-3.4 | Parallel support | Unsupported | Unsupported | Versioned Ruby workflows run on Linux. |
| MRI current | Parallel support | Parallel support | Parallel support | Current Ruby workflow covers the declared OS platforms. |
| MRI head | Parallel support | Unsupported | Unsupported | CI is allowed to fail while Ruby is in development. |
| JRuby (all CI lanes) | Parallel support | Unsupported | Unsupported | Engine workflows run on Linux; macOS and Windows are not exercised by CI. |
| TruffleRuby (all CI lanes) | Parallel support | Unsupported | Unsupported | Never shipped a Windows build (zero Windows assets across 66 releases scanned 2026-10-10); setup-ruby hard-fails ([source](https://github.com/ruby/setup-ruby/blob/master/README.md)) |

### Federated DVCS

<details markdown="1">
 <summary>Find this repo on federated forges (Coming soon!)</summary>

| Federated [DVCS][💎d-in-dvcs] Repository | Status | Issues | PRs | Wiki | CI |
|-------------------------------------------------|-------------------------------------------|-------------------|------------------|-----------------|----------------|
| 🧪 [ruby-oauth/oauth2 on GitLab][📜src-gl] | The Truth | [💚][🤝gl-issues] | [💚][🤝gl-pulls] | [💚][📜gl-wiki] | 🐭 Tiny Matrix |
| 🧊 [ruby-oauth/oauth2 on CodeBerg][📜src-cb] | An Ethical Mirror ([Donate][🤝cb-donate]) | [💚][🤝cb-issues] | [💚][🤝cb-pulls] | ➖ | ⭕️ No Matrix |
| 🐙 [ruby-oauth/oauth2 on GitHub][📜src-gh] | Another Mirror | [💚][🤝gh-issues] | [💚][🤝gh-pulls] | [💚][📜gh-wiki] | 💯 Full Matrix |

</details>

### Enterprise Support

[![Tidelift](https://tidelift.com/badges/package/rubygems/oauth2)](https://tidelift.com/subscription/pkg/rubygems-oauth2?utm_source=rubygems-oauth2&utm_medium=referral&utm_campaign=readme)

Available as part of the Tidelift Subscription.

<details markdown="1">
 <summary>Need enterprise-level guarantees?</summary>

The maintainers of this and thousands of other packages are working with Tidelift to deliver commercial support and maintenance for the open source packages you use to build your applications. Save time, reduce risk, and improve code health, while paying the maintainers of the exact packages you use.

[![Get help from me on Tidelift][🏙️entsup-tidelift-img]][🏙️entsup-tidelift]

- 💡Subscribe for support guarantees covering _all_ your FLOSS dependencies
- 💡Tidelift is part of [Sonar][🏙️entsup-tidelift-sonar]
- 💡Tidelift pays maintainers to maintain the software you depend on!<br/>📊`@`Pointy Haired Boss: An [enterprise support][🏙️entsup-tidelift] subscription is "[never gonna let you down][🧮kloc]", and *supports* open source maintainers

Alternatively:

- [![Ruby Users Forum][✉️ruby-forum-img]][✉️ruby-forum]
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

## OAuth2 for Enterprise

Available as part of the Tidelift Subscription.

The maintainers of OAuth2 and thousands of other packages are working with Tidelift to deliver commercial support and maintenance for the open source packages you use to build your applications. Save time, reduce risk, and improve code health, while paying the maintainers of the exact packages you use. [Learn more.][tidelift-ref]

[tidelift-ref]: https://tidelift.com/subscription/pkg/rubygems-oauth2?utm_source=rubygems-oauth2&utm_medium=referral&utm_campaign=enterprise

## Security contact information

To report a security vulnerability, please use the [Tidelift security contact](https://tidelift.com/security).
Tidelift will coordinate the fix and disclosure.

For more see [SECURITY.md][🚎sec-pol].

## Why should you upgrade to version v2.0?

- Officially support Ruby versions >= 2.7
- Unofficially support Ruby versions >= 2.5
- Incidentally support Ruby versions >= 2.2
- Drop support for the expired MAC Draft (all versions)
- Support IETF rfc7523 JWT Bearer Tokens
- Support IETF rfc7231 Relative Location in Redirect
- Support IETF rfc6749 Don't set oauth params when nil
- Support [OIDC 1.0 Private Key JWT](https://openid.net/specs/openid-connect-core-1_0.html#ClientAuthentication); based on the OAuth JWT assertion specification [(RFC 7523)](https://tools.ietf.org/html/rfc7523)
- Support new formats, including from [jsonapi.org](http://jsonapi.org/format/): `application/vdn.api+json`, `application/vnd.collection+json`, `application/hal+json`, `application/problem+json`
- Adds new option to `OAuth2::Client#get_token`:
    - `:access_token_class` (`AccessToken`); user specified class to use for all calls to `get_token`
- Adds new option to `OAuth2::AccessToken#initialize`:
    - `:expires_latency` (`nil`); number of seconds by which AccessToken validity will be reduced to offset latency
- By default, keys are transformed to camel case.
  - Original keys will still work as previously, in most scenarios, thanks to `rash_alt` gem.
  - However, this is a _breaking_ change if you rely on `response.parsed.to_h`, as the keys in the result will be camel case.
  - As of version 2.0.4 you can turn key transformation off with the `snaky: false` option.
- By default, the `:auth_scheme` is now `:basic_auth` (instead of `:request_body`)
  - Third-party strategies and gems may need to be updated if a provider was requiring client id/secret in the request body
- [... A lot more](https://gitlab.com/oauth-xx/oauth2/-/blob/main/CHANGELOG.md#2.0.0)

## ⚙️ Configuration

## 🔧 Basic Usage

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

[kettle-readme-backers]: https://github.com/ruby-oauth/oauth2/blob/main/bin/kettle-readme-backers

### Another way to support open-source

I’m driven by a passion to foster a thriving open-source community – a space where people can tackle complex problems, no matter how small. Revitalizing libraries that have fallen into disrepair, and building new libraries focused on solving real-world challenges, are my passions. I was recently affected by layoffs, and the tech jobs market is unwelcoming. I’m reaching out here because your support would significantly aid my efforts to provide for my family, and my farm (11 🐔 chickens, 2 🐶 dogs, 3 🐰 rabbits, 8 🐈‍ cats).

If you work at a company that uses my work, please encourage them to support me as a corporate sponsor. My work on gems you use might show up in `bundle fund`.

I’m developing a new library, [floss_funding][🖇floss-funding-gem], designed to empower open-source developers like myself to get paid for the work we do, in a sustainable way. Please give it a look.

**[Floss-Funding.dev][🖇floss-funding.dev]: 👉️ No network calls. 👉️ No tracking. 👉️ No oversight. 👉️ Minimal crypto hashing. 💡 Easily disabled nags**

[![OpenCollective Backers][🖇osc-backers-i]][🖇osc-backers] [![OpenCollective Sponsors][🖇osc-sponsors-i]][🖇osc-sponsors] [![Sponsor Me on Github][🖇sponsor-img]][🖇sponsor] [![Liberapay Goal Progress][⛳liberapay-img]][⛳liberapay] [![Donate on PayPal][🖇paypal-img]][🖇paypal] [![Buy me a coffee][🖇buyme-small-img]][🖇buyme] [![Donate to my FLOSS efforts at ko-fi.com][🖇kofi-img]][🖇kofi]

## 🔐 Security

See [SECURITY.md][🔐security].

## 🤝 Contributing

If you need some ideas of where to help, you could work on adding more code coverage,
check [issues][🤝gh-issues] or [PRs][🤝gh-pulls], or use the gem and think about how it could be better.

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

<details markdown="1">
 <summary>⭐️ Star History</summary>

<a href="https://star-history.dera.page/#ruby-oauth/oauth2&type=date&legend=top-left">
 <picture>
 <source media="(prefers-color-scheme: dark)" srcset="https://star-history.dera.page/svg?repos=ruby-oauth/oauth2&type=date&theme=dark&legend=top-left" />
 <source media="(prefers-color-scheme: light)" srcset="https://star-history.dera.page/svg?repos=ruby-oauth/oauth2&type=date&legend=top-left" />
 <img alt="Star History Chart" src="https://star-history.dera.page/svg?repos=ruby-oauth/oauth2&type=date&legend=top-left" />
 </picture>
</a>

</details>

## 📌 Versioning

This library aims to adhere to [Semantic Versioning 2.0.0][semver].
Violations of this scheme should be reported as bugs. Specifically,
if a minor or patch version is released that breaks backward
compatibility, a new version should be immediately released that
restores compatibility. Breaking changes to the public API will
only be introduced with new major versions.

As a result of this policy, you can (and should) specify a
dependency on this gem using the [Pessimistic Version Constraint][pvc] with two digits of precision.

For example:

```ruby
spec.add_dependency "oauth2", "~> 1.4"
```

[semver]: http://semver.org/
[pvc]: http://guides.rubygems.org/patterns/#pessimistic-version-constraint

## 📄 License

The gem is available as open source under the terms of
the [MIT](https://github.com/ruby-oauth/oauth2/blob/main/MIT.md) [![License: MIT][📄license-img]][📄license-ref].

### © Copyright

See [LICENSE.md][📄license] for the official copyright notice.

<details markdown="1">
<summary>Copyright holders</summary>

- Copyright (c) 2010 Diego Elio 'Flameeyes' Pettenò
- Copyright (c) 2010-2014, 2016-2017 Erik Michaels-Ober
- Copyright (c) 2010 Jeremy Kemper
- Copyright (c) 2010-2011, 2014 Michael Bleigh
- Copyright (c) 2010-2011 Paul Walker
- Copyright (c) 2010 rick
- Copyright (c) 2010 Tim Habermaas
- Copyright (c) 2010 Wynn Netherland
- Copyright (c) 2011 Alexander Lang
- Copyright (c) 2011 Greg Spurrier
- Copyright (c) 2011 Jay Adkisson
- Copyright (c) 2011 Josh Kalderimis
- Copyright (c) 2011 Luke Saunders
- Copyright (c) 2011 Max Golovnia
- Copyright (c) 2011 Simon Gate
- Copyright (c) 2012 Bas Vodde
- Copyright (c) 2012 Damian Janowski
- Copyright (c) 2012 Daniël van de Burgt
- Copyright (c) 2012 Dorren Chen
- Copyright (c) 2012 Igor Sales
- Copyright (c) 2012 Leigh Caplan
- Copyright (c) 2012 Michael Andrews
- Copyright (c) 2012 Mike Skalnik
- Copyright (c) 2012 Omer Rauchwerger
- Copyright (c) 2012 Saverio Trioni
- Copyright (c) 2012 Trent Ogren
- Copyright (c) 2012 Vsevolod Romashov
- Copyright (c) 2013 Antonio Tapiador del Dujo
- Copyright (c) 2013 Eduardo Gurgel
- Copyright (c) 2013 Geostellar Developer
- Copyright (c) 2013 Rainux Luo
- Copyright (c) 2013 Taylor Hedberg
- Copyright (c) 2013 Tim Clem
- Copyright (c) 2014 Ellis Berner
- Copyright (c) 2014 Olivier Lacan
- Copyright (c) 2014 Peter Souter
- Copyright (c) 2014 Steven Davidovitz
- Copyright (c) 2015 Thomas Walpole
- Copyright (c) 2016 Anton Ilin
- Copyright (c) 2016 Bo Jeanes
- Copyright (c) 2016 Edward Rudd
- Copyright (c) 2016 Lawrence Oluyede
- Copyright (c) 2016 Linus Pettersson
- Copyright (c) 2016 Motoshi Nishihira
- Copyright (c) 2016 Tim Rogers
- Copyright (c) 2017 Nathaniel Bibler
- Copyright (c) 2017 Pierre Schambacher
- Copyright (c) 2018 asm__
- Copyright (c) 2018 Lomey
- Copyright (c) 2018-2023, 2026 Peter H. Boling
- Copyright (c) 2020 An Vo
- Copyright (c) 2020 Jon Palmer
- Copyright (c) 2020 Stephen Reid
- Copyright (c) 2021 Anders Carling
- Copyright (c) 2021 dobon
- Copyright (c) 2022 Jonathan Rochkind
- Copyright (c) 2026 Daniel Pepper

</details>

## 🤑 A request for help

Maintainers have teeth and need to pay their dentists.
After getting laid off in an RIF in March, and encountering difficulty finding a new one,
I began spending most of my time building open source tools.
I'm hoping to be able to pay for my kids' health insurance this month,
so if you value the work I am doing, I need your support.
Please consider sponsoring me or the project.

To join the community or get help, use the RubyForum or Discord.

[![Ruby Users Forum][✉️ruby-forum-img]][✉️ruby-forum]
[![Live Chat on Discord][✉️discord-invite-img-ftb]][✉️discord-invite]

To say "thanks!" ☝️ Join the community or 👇️ send money.

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
[🖇kofi-img]: https://img.shields.io/badge/ko--fi-%E2%9C%93-a51611.svg?style=flat
[🖇kofi]: https://ko-fi.com/pboling
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
[✉️ruby-forum-top-img]: https://img.shields.io/discourse/topics?server=https%3A%2F%2Fwww.rubyforum.org&style=flat&logo=discourse&label=Ruby%20Users%20Forum
[✉️ruby-forum-img]: https://img.shields.io/discourse/topics?server=https%3A%2F%2Fwww.rubyforum.org&style=for-the-badge&logo=discourse&label=Ruby%20Users%20Forum
[✉️ruby-forum]: https://www.rubyforum.org/tag/oauth2

[✇bundle-group-pattern]: https://gist.github.com/pboling/4564780
[⛳️gem-namespace]: https://github.com/ruby-oauth/oauth2
[⛳️namespace-img]: https://img.shields.io/badge/namespace-OAuth2-3C2D2D.svg?style=square&logo=ruby&logoColor=white
[⛳️gem-name]: https://clickgems.clickhouse.com/dashboard/oauth2
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
[📜src-gh-img]: https://img.shields.io/badge/GitHub-238636?style=for-the-badge&logo=GitHub&logoColor=green
[📜src-gh]: https://github.com/ruby-oauth/oauth2
[📜docs-cr-rd-img]: https://img.shields.io/badge/RubyDoc-Current_Release-943CD2?style=for-the-badge&logo=readthedocs&logoColor=white
[📜docs-head-rd-img]: https://img.shields.io/badge/YARD_on_Galtzo.com-HEAD-943CD2?style=for-the-badge&logo=readthedocs&logoColor=white
[📜gl-wiki]: https://gitlab.com/ruby-oauth/oauth2/-/wikis/home
[📜gh-wiki]: https://github.com/ruby-oauth/oauth2/wiki
[📜gl-wiki-img]: https://img.shields.io/badge/wiki-gitlab-943CD2.svg?style=for-the-badge&logo=gitlab&logoColor=white
[📜gh-wiki-img]: https://img.shields.io/badge/wiki-github-943CD2.svg?style=for-the-badge&logo=github&logoColor=white
[👽dl-rank]: https://clickgems.clickhouse.com/dashboard/oauth2
[👽dl-ranki]: https://img.shields.io/gem/dt/oauth2.svg
[👽version]: https://clickgems.clickhouse.com/dashboard/oauth2
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
[🚎jruby-10.0-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/jruby-10.0.yml
[🚎truby-22.3-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/truffleruby-22.3.yml
[🚎truby-23.1-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/truffleruby-23.1.yml
[🚎truby-24.2-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/truffleruby-24.2.yml
[🚎truby-25.0-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/truffleruby-25.0.yml
[🚎truby-33.0-wf]: https://github.com/ruby-oauth/oauth2/actions/workflows/truffleruby-33.0.yml
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
[💎ruby-1.9i]: https://img.shields.io/badge/Ruby-1.9_(%F0%9F%9A%ABCI)-AABBCC?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-2.0i]: https://img.shields.io/badge/Ruby-2.0_(%F0%9F%9A%ABCI)-AABBCC?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-2.1i]: https://img.shields.io/badge/Ruby-2.1_(%F0%9F%9A%ABCI)-AABBCC?style=for-the-badge&logo=ruby&logoColor=white
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
[💎ruby-c-i]: https://img.shields.io/badge/Ruby-current-CC342D?style=for-the-badge&logo=ruby&logoColor=green
[💎ruby-headi]: https://img.shields.io/badge/Ruby-HEAD-CC342D?style=for-the-badge&logo=ruby&logoColor=blue
[💎truby-22.3i]: https://img.shields.io/badge/Truffle_Ruby-22.3-34BCB1?style=for-the-badge&logo=ruby&logoColor=pink
[💎truby-23.1i]: https://img.shields.io/badge/Truffle_Ruby-23.1-34BCB1?style=for-the-badge&logo=ruby&logoColor=pink
[💎truby-24.2i]: https://img.shields.io/badge/Truffle_Ruby-24.2-34BCB1?style=for-the-badge&logo=ruby&logoColor=pink
[💎truby-25.0i]: https://img.shields.io/badge/Truffle_Ruby-25.0-34BCB1?style=for-the-badge&logo=ruby&logoColor=pink
[💎truby-33.0i]: https://img.shields.io/badge/Truffle_Ruby-33.0-34BCB1?style=for-the-badge&logo=ruby&logoColor=pink
[💎truby-c-i]: https://img.shields.io/badge/Truffle_Ruby-current-34BCB1?style=for-the-badge&logo=ruby&logoColor=green
[💎jruby-9.2i]: https://img.shields.io/badge/JRuby-9.2-FBE742?style=for-the-badge&logo=ruby&logoColor=red
[💎jruby-9.3i]: https://img.shields.io/badge/JRuby-9.3-FBE742?style=for-the-badge&logo=ruby&logoColor=red
[💎jruby-9.4i]: https://img.shields.io/badge/JRuby-9.4-FBE742?style=for-the-badge&logo=ruby&logoColor=red
[💎jruby-10.0i]: https://img.shields.io/badge/JRuby-10.0-FBE742?style=for-the-badge&logo=ruby&logoColor=red
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
[🧮kloc-img]: https://img.shields.io/badge/KLOC-5.053-FFDD67.svg?style=for-the-badge&logo=YouTube&logoColor=blue
[🔐security]: https://github.com/ruby-oauth/oauth2/blob/main/SECURITY.md
[🔐security-img]: https://img.shields.io/badge/security-policy-259D6C.svg?style=flat
[📄copyright-notice-explainer]: https://opensource.stackexchange.com/questions/5778/why-do-licenses-such-as-the-mit-license-specify-a-single-year
[📄license]: LICENSE.md
[📄license-ref]: https://github.com/ruby-oauth/oauth2/blob/main/MIT.md
[📄license-img]: https://img.shields.io/badge/License-MIT-259D6C.svg
[📄license-compat]: https://www.apache.org/legal/resolved.html#category-a
[📄license-compat-img]: https://img.shields.io/badge/Apache_Compatible:_Category_A-%E2%9C%93-259D6C.svg?style=flat&logo=Apache

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

[🚎sec-pol]: https://gitlab.com/oauth-xx/oauth2/-/blob/main/SECURITY.md
