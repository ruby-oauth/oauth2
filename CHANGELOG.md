# Changelog

[![SemVer 2.0.0][📌semver-img]][📌semver] [![Keep-A-Changelog 1.0.0][📗keep-changelog-img]][📗keep-changelog]

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog][📗keep-changelog],
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html),
and [yes][📌major-versions-not-sacred], platform and engine support are part of the [public API][📌semver-breaking].
Please file a bug if you notice a violation of semantic versioning.

[📌semver]: https://semver.org/spec/v2.0.0.html
[📌semver-img]: https://img.shields.io/badge/semver-2.0.0-FFDD67.svg?style=flat
[📌semver-breaking]: https://github.com/semver/semver/issues/716#issuecomment-869336139
[📌major-versions-not-sacred]: https://tom.preston-werner.com/2022/05/23/major-version-numbers-are-not-sacred.html
[📗keep-changelog]: https://keepachangelog.com/en/1.0.0/
[📗keep-changelog-img]: https://img.shields.io/badge/keep--a--changelog-1.0.0-FFDD67.svg?style=flat

## [Unreleased]

## [1.4.12] - 2026-10-26

### Added

- kettle-jem-template-20260720-001 - READMEs can now display configured
  corporate sponsor logos.
- kettle-jem-template-20260720-005 - README Support & Community links now
  include RubyForum.
- kettle-jem-template-20260726-001 - Projects now include YARD lint
  configuration and documentation dependencies so documentation issues fail
  before generated docs are refreshed.
- kettle-jem-template-20260727-001 - Spec harness documentation now lists the
  RSpec helpers provided by `kettle-test`.
- kettle-jem-template-20260729-005 - Gemspec metadata now publishes this
  project's RubyForum tag as `mailing_list_uri`, and support docs link to the
  tagged RubyForum community alongside Discord.
- kettle-jem-template-20260913-001 - Templating now also surfaces a review
  entry in `dependency_conflicts.resolve` when a direct development
  dependency doesn't support one or more of this project's declared
  `engines:` and has no template-managed modular home (e.g. `sqlite3` on
  `jruby`). Review each entry and pick a resolution per the project's own
  engine support needs.

### Changed

- kettle-jem-template-20260716-002 - Gemspecs now ship fewer repository-only
  files, reducing package noise for downstream packagers.
- kettle-jem-template-20260720-002 - Development Gemfiles now use the released
  `tree_sitter_language_pack` gem 1.13.3 or newer by default.
- kettle-jem-template-20260725-002 - Version specs now use `anonymous_loader` to
  cover `version.rb` without redefining constants, or are removed when version
  specs are not managed for the project.
- kettle-jem-template-20260728-001 - Generated Ruby workflows now use clearer
  setup-ruby-flash planning and can prepare appraisal-only jobs without
  installing the main Gemfile bundle.
- kettle-jem-template-20260801-001 - Generated README gem dashboard links now
  use ClickGems instead of BestGems.

- [kc] kettle-jem/template: updated 37 project files:
  - code and tests (2)
  - dependencies (25)
  - documentation (1)
  - other (3)
  - workflows (6)

### Deprecated

### Removed

### Fixed

- [#771](https://github.com/ruby-oauth/oauth2/pull/771) Return raw response bodies only for JSON decode failures, and propagate unrelated parser errors (@dpep)
- Constrain JSON and XML parser dependencies to versions compatible with supported older runtimes.
- Constrain the TruffleRuby 23.1 appraisal to Faraday versions compatible with its parser.

- kettle-jem-template-20260720-003 - StructuredMerge Git diff driver config now
  uses the installed `smorg-rb` driver command.
- kettle-jem-template-20260725-001 - Release pull request branches beginning
  with `feature/release` now run JRuby and TruffleRuby workflows.
- kettle-jem-template-20260726-002 - Generated version files now document their
  version namespace and constants, reducing warning-only YARD lint output.
- kettle-jem-template-20260726-003 - Coverage upload steps now treat Coveralls,
  QLTY, and Codecov as optional, so provider outages do not fail CI when local
  coverage thresholds still pass.
- kettle-jem-template-20260728-002 - Generated RuboCop configs now ignore the
  same `gemfiles/vendor/bundle` tree as `.gitignore`, so vendored dependency
  installs are not reported as project lint debt.
- kettle-jem-template-20260728-003 - Generated dep-heads workflows now run
  TruffleRuby jobs with current RubyGems and Bundler, avoiding setup failures
  before the test suite starts.
- kettle-jem-template-20260728-004 - Generated dep-heads workflows now use the
  setup-ruby Bundler install path for direct appraisal Gemfiles, avoiding rv
  lockfile parser failures on Git and path dependencies.
- kettle-jem-template-20260728-005 - VersionGem bootstrap now creates the
  missing canonical version spec when a project only has shim namespace version
  specs.
- kettle-jem-template-20260729-001 - Generated JRuby 9.4 workflows now use the
  legacy manual bundle install path, avoiding setup-time Bundler full-index
  failures against `gem.coop`.
- kettle-jem-template-20260729-003 - Old-Ruby gems below the VersionGem runtime
  floor now get managed minimal `version.rb` files and anonymous-loader version
  specs without adding `version_gem`.
- kettle-jem-template-20260730-001 - Gemspec package file enumeration now runs
  relative to the gemspec directory, so release package contents stay correct
  even when the gemspec is loaded from another working directory.
- kettle-jem-template-20260801-002 - Generated RSpec helpers now normalize
  managed configuration block bindings structurally, preventing mixed block
  parameter names from producing invalid configuration after a merge.
- kettle-jem-template-20260801-003 - Generated project metadata and
  documentation now normalize configured underscore hostnames to valid
  hyphenated hostnames.
- kettle-jem-template-20260801-004 - Generated organization README logos now
  use GitHub's stable organization avatar endpoint instead of assuming a
  matching Galtzo-hosted asset exists.
- kettle-jem-template-20260802-001 - Devcontainer JSON files now merge as JSONC,
  preserving comments and trailing commas during template updates.

### Security

- Prevent protocol-relative redirects from sending bearer tokens to an attacker-controlled host ([GHSA-pp92-crg2-gfv9](https://github.com/ruby-oauth/oauth2/security/advisories/GHSA-pp92-crg2-gfv9)).

## [1.4.11] - 2022-09-16
- Complete migration to main branch as default (@pboling)
- Complete migration to Gitlab, updating all links, and references in VCS-managed files (@pboling)

## [1.4.10] - 2022-07-01
- FIPS Compatibility [#587](https://gitlab.com/oauth-xx/oauth2/-/merge_requests/587) (@akostadinov)

## [1.4.9] - 2022-02-20
- Fixes compatibility with Faraday v2 [572](https://gitlab.com/oauth-xx/oauth2/-/issues/572)
- Includes supported versions of Faraday in test matrix:
  - Faraday ~> 2.2.0 with Ruby >= 2.6
  - Faraday ~> 1.10 with Ruby >= 2.4
  - Faraday ~> 0.17.3 with Ruby >= 1.9
- Add Windows and MacOS to test matrix

## [1.4.8] - 2022-02-18
- MFA is now required to push new gem versions (@pboling)
- README overhaul w/ new Ruby Version and Engine compatibility policies (@pboling)
- [#569](https://gitlab.com/oauth-xx/oauth2/-/merge_requests/569) Backport fixes ([#561](https://gitlab.com/oauth-xx/oauth2/-/merge_requests/561) by @ryogift), and add more fixes, to allow faraday 1.x and 2.x (@jrochkind)
- Improve Code Coverage tracking (Coveralls, CodeCov, CodeClimate), and enable branch coverage (@pboling)
- Add CodeQL, Security Policy, Funding info (@pboling)
- Added Ruby 3.1, jruby, jruby-head, truffleruby, truffleruby-head to build matrix (@pboling)
- [#543](https://gitlab.com/oauth-xx/oauth2/-/merge_requests/543) - Support for more modern Open SSL libraries (@pboling)

## [1.4.7] - 2021-03-19
- [#541](https://gitlab.com/oauth-xx/oauth2/-/merge_requests/541) - Backport fix to expires_at handling [#533](https://gitlab.com/oauth-xx/oauth2/-/merge_requests/533) to 1-4-stable branch. (@dobon)

## [1.4.6] - 2021-03-19
- [#540](https://gitlab.com/oauth-xx/oauth2/-/merge_requests/540) - Add VERSION constant (@pboling)
- [#537](https://gitlab.com/oauth-xx/oauth2/-/merge_requests/537) - Fix crash in OAuth2::Client#get_token (@anderscarling)
- [#538](https://gitlab.com/oauth-xx/oauth2/-/merge_requests/538) - Remove reliance on globally included OAuth2 in tests, analogous to [#539](https://gitlab.com/oauth-xx/oauth2/-/merge_requests/539) on main branch (@anderscarling)

## [1.4.5] - 2021-03-18
- [#535](https://gitlab.com/oauth-xx/oauth2/-/merge_requests/535) - Compatibility with range of supported Ruby OpenSSL versions, Rubocop updates, Github Actions, analogous to [#536](https://gitlab.com/oauth-xx/oauth2/-/merge_requests/536) on main branch (@pboling)
- [#518](https://gitlab.com/oauth-xx/oauth2/-/merge_requests/518) - Add extract_access_token option to OAuth2::Client (@jonspalmer)
- [#507](https://gitlab.com/oauth-xx/oauth2/-/merge_requests/507) - Fix camel case content type, response keys (@anvox)
- [#500](https://gitlab.com/oauth-xx/oauth2/-/merge_requests/500) - Fix YARD documentation formatting (@olleolleolle)

## [1.4.4] - 2020-02-12
- [#408](https://gitlab.com/oauth-xx/oauth2/-/merge_requests/408) - Fixed expires_at for formatted time (@Lomey)

## [1.4.3] - 2020-01-29
- [#483](https://gitlab.com/oauth-xx/oauth2/-/merge_requests/483) - add project metadata to gemspec (@orien)
- [#495](https://gitlab.com/oauth-xx/oauth2/-/merge_requests/495) - support additional types of access token requests (@SteveyblamFreeagent, @thomcorley, @dgholz)
  - Adds support for private_key_jwt and tls_client_auth
- [#433](https://gitlab.com/oauth-xx/oauth2/-/merge_requests/433) - allow field names with square brackets and numbers in params (@asm256)

## [1.4.2] - 2019-10-01
- [#478](https://gitlab.com/oauth-xx/oauth2/-/merge_requests/478) - support latest version of faraday & fix build (@pboling)
  - Officially support Ruby 2.6 and truffleruby

## [1.4.1] - 2018-10-13
- [#417](https://gitlab.com/oauth-xx/oauth2/-/merge_requests/417) - update jwt dependency (@thewoolleyman)
- [#419](https://gitlab.com/oauth-xx/oauth2/-/merge_requests/419) - remove rubocop dependency (temporary, added back in [#423](https://gitlab.com/oauth-xx/oauth2/-/merge_requests/423)) (@pboling)
- [#418](https://gitlab.com/oauth-xx/oauth2/-/merge_requests/418) - update faraday dependency (@pboling)
- [#420](https://gitlab.com/oauth-xx/oauth2/-/merge_requests/420) - update [oauth2.gemspec](https://gitlab.com/oauth-xx/oauth2/-/blob/1-4-stable/oauth2.gemspec) (@pboling)
- [#421](https://gitlab.com/oauth-xx/oauth2/-/merge_requests/421) - fix [CHANGELOG.md](https://gitlab.com/oauth-xx/oauth2/-/blob/1-4-stable/CHANGELOG.md) for previous releases (@pboling)
- [#422](https://gitlab.com/oauth-xx/oauth2/-/merge_requests/422) - update [LICENSE](https://gitlab.com/oauth-xx/oauth2/-/blob/1-4-stable/LICENSE) and [README.md](https://gitlab.com/oauth-xx/oauth2/-/blob/1-4-stable/README.md) (@pboling)
- [#423](https://gitlab.com/oauth-xx/oauth2/-/merge_requests/423) - update [builds](https://travis-ci.org/oauth-xx/oauth2/builds), [Rakefile](https://gitlab.com/oauth-xx/oauth2/-/blob/1-4-stable/Rakefile) (@pboling)
  - officially document supported Rubies
    * Ruby 1.9.3
    * Ruby 2.0.0
    * Ruby 2.1
    * Ruby 2.2
    * [JRuby 1.7][jruby-1.7] (targets MRI v1.9)
    * [JRuby 9.0][jruby-9.0] (targets MRI v2.0)
    * Ruby 2.3
    * Ruby 2.4
    * Ruby 2.5
    * [JRuby 9.1][jruby-9.1] (targets MRI v2.3)
    * [JRuby 9.2][jruby-9.2] (targets MRI v2.5)

[jruby-1.7]: https://www.jruby.org/2017/05/11/jruby-1-7-27.html
[jruby-9.0]: https://www.jruby.org/2016/01/26/jruby-9-0-5-0.html
[jruby-9.1]: https://www.jruby.org/2017/05/16/jruby-9-1-9-0.html
[jruby-9.2]: https://www.jruby.org/2018/05/24/jruby-9-2-0-0.html

## [1.4.0] - 2017-06-09
- Drop Ruby 1.8.7 support (@sferik)
- Fix some RuboCop offenses (@sferik)
- _Dependency_: Remove Yardstick (@sferik)
- _Dependency_: Upgrade Faraday to 0.12 (@sferik)

## [1.3.1] - 2017-03-03
- Add support for Ruby 2.4.0 (@pschambacher)
- _Dependency_: Upgrade Faraday to Faraday 0.11 (@mcfiredrill, @rhymes, @pschambacher)

## [1.3.0] - 2016-12-28
- Add support for header-based authentication to the `Client` so it can be used across the library (@bjeanes)
- Default to header-based authentication when getting a token from an authorisation code (@maletor)
- **Breaking**: Allow an `auth_scheme` (`:basic_auth` or `:request_body`) to be set on the client, defaulting to `:request_body` to maintain backwards compatibility (@maletor, @bjeanes)
- Handle `redirect_uri` according to the OAuth 2 spec, so it is passed on redirect and at the point of token exchange (@bjeanes)
- Refactor handling of encoding of error responses (@urkle)
- Avoid instantiating an `Error` if there is no error to raise (@urkle)
- Add support for Faraday 0.10 (@rhymes)

## [1.2.0] - 2016-07-01
- Properly handle encoding of error responses (so we don't blow up, for example, when Google's response includes a ∞) (@Motoshi-Nishihira)
- Make a copy of the options hash in `AccessToken#from_hash` to avoid accidental mutations (@Linuus)
- Use `raise` rather than `fail` to throw exceptions (@sferik)

## [1.1.0] - 2016-01-30
- Various refactors (eliminating `Hash#merge!` usage in `AccessToken#refresh!`, use `yield` instead of `#call`, freezing mutable objects in constants, replacing constants with class variables) (@sferik)
- Add support for Rack 2, and bump various other dependencies (@sferik)

## [1.0.0] - 2014-07-09
### Added
- Add an implementation of the MAC token spec.
### Fixed
- Fix Base64.strict_encode64 incompatibility with Ruby 1.8.7.

## [0.5.0] - 2011-07-29
### Changed
- *breaking* `oauth_token` renamed to `oauth_bearer`.
- *breaking* `authorize_path` Client option renamed to `authorize_url`.
- *breaking* `access_token_path` Client option renamed to `token_url`.
- *breaking* `access_token_method` Client option renamed to `token_method`.
- *breaking* `web_server` renamed to `auth_code`.

## [0.4.1] - 2011-04-20

## [0.4.0] - 2011-04-20

## [0.3.0] - 2011-04-08

## [0.2.0] - 2011-04-01

## [0.1.1] - 2011-01-12

## [0.1.0] - 2010-10-13

## [0.0.13] + [0.0.12] + [0.0.11] - 2010-08-17

## [0.0.10] - 2010-06-19

## [0.0.9] - 2010-06-18

## [0.0.8] + [0.0.7] - 2010-04-27

## [0.0.6] - 2010-04-25

## [0.0.5] - 2010-04-23

## [0.0.4] + [0.0.3] + [0.0.2] + [0.0.1] - 2010-04-22

[0.0.1]: https://gitlab.com/oauth-xx/oauth2/-/compare/311d9f4...v0.0.1
[0.0.2]: https://gitlab.com/oauth-xx/oauth2/-/compare/v0.0.1...v0.0.2
[0.0.3]: https://gitlab.com/oauth-xx/oauth2/-/compare/v0.0.2...v0.0.3
[0.0.4]: https://gitlab.com/oauth-xx/oauth2/-/compare/v0.0.3...v0.0.4
[0.0.5]: https://gitlab.com/oauth-xx/oauth2/-/compare/v0.0.4...v0.0.5
[0.0.6]: https://gitlab.com/oauth-xx/oauth2/-/compare/v0.0.5...v0.0.6
[0.0.7]: https://gitlab.com/oauth-xx/oauth2/-/compare/v0.0.6...v0.0.7
[0.0.8]: https://gitlab.com/oauth-xx/oauth2/-/compare/v0.0.7...v0.0.8
[0.0.9]: https://gitlab.com/oauth-xx/oauth2/-/compare/v0.0.8...v0.0.9
[0.0.10]: https://gitlab.com/oauth-xx/oauth2/-/compare/v0.0.9...v0.0.10
[0.0.11]: https://gitlab.com/oauth-xx/oauth2/-/compare/v0.0.10...v0.0.11
[0.0.12]: https://gitlab.com/oauth-xx/oauth2/-/compare/v0.0.11...v0.0.12
[0.0.13]: https://gitlab.com/oauth-xx/oauth2/-/compare/v0.0.12...v0.0.13
[0.1.0]: https://gitlab.com/oauth-xx/oauth2/-/compare/v0.0.13...v0.1.0
[0.1.1]: https://gitlab.com/oauth-xx/oauth2/-/compare/v0.1.0...v0.1.1
[0.2.0]: https://gitlab.com/oauth-xx/oauth2/-/compare/v0.1.1...v0.2.0
[0.3.0]: https://gitlab.com/oauth-xx/oauth2/-/compare/v0.2.0...v0.3.0
[0.4.0]: https://gitlab.com/oauth-xx/oauth2/-/compare/v0.3.0...v0.4.0
[0.4.1]: https://gitlab.com/oauth-xx/oauth2/-/compare/v0.4.0...v0.4.1
[0.5.0]: https://gitlab.com/oauth-xx/oauth2/-/compare/v0.4.1...v0.5.0
[1.0.0]: https://gitlab.com/oauth-xx/oauth2/-/compare/v0.9.4...v1.0.0
[1.1.0]: https://gitlab.com/oauth-xx/oauth2/-/compare/v1.0.0...v1.1.0
[1.2.0]: https://gitlab.com/oauth-xx/oauth2/-/compare/v1.1.0...v1.2.0
[1.3.0]: https://gitlab.com/oauth-xx/oauth2/-/compare/v1.2.0...v1.3.0
[1.3.1]: https://gitlab.com/oauth-xx/oauth2/-/compare/v1.3.0...v1.3.1
[1.4.0]: https://gitlab.com/oauth-xx/oauth2/-/compare/v1.3.1...v1.4.0
[1.4.1]: https://gitlab.com/oauth-xx/oauth2/-/compare/v1.4.0...v1.4.1
[1.4.2]: https://gitlab.com/oauth-xx/oauth2/-/compare/v1.4.1...v1.4.2
[1.4.3]: https://gitlab.com/oauth-xx/oauth2/-/compare/v1.4.2...v1.4.3
[1.4.4]: https://gitlab.com/oauth-xx/oauth2/-/compare/v1.4.3...v1.4.4
[1.4.5]: https://gitlab.com/oauth-xx/oauth2/-/compare/v1.4.4...v1.4.5
[1.4.6]: https://gitlab.com/oauth-xx/oauth2/-/compare/v1.4.5...v1.4.6
[1.4.7]: https://gitlab.com/oauth-xx/oauth2/-/compare/v1.4.6...v1.4.7
[1.4.8]: https://gitlab.com/oauth-xx/oauth2/-/compare/v1.4.7...v1.4.8
[1.4.9]: https://gitlab.com/oauth-xx/oauth2/-/compare/v1.4.8...v1.4.9
[1.4.10]: https://gitlab.com/oauth-xx/oauth2/-/compare/v1.4.9...v1.4.10
[1.4.11]: https://gitlab.com/oauth-xx/oauth2/-/compare/v1.4.10...v1.4.11
[1.4.12]: https://github.com/ruby-oauth/oauth2/compare/v1.4.11...v1.4.12
[unreleased]: https://github.com/ruby-oauth/oauth2/compare/v1.4.12...HEAD
