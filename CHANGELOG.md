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
### Added
- .env.local.example for contributor happiness
- note lack of builds for JRuby 9.2, 9.3 & Truffleruby 22.3, 23.0
  - [actions/runner - issues/2347][GHA-continue-on-error-ui]
  - [community/discussions/15452][GHA-allow-failure]
### Changed
- [gh!669][gh!669] - Upgrade to kettle-dev v1.1.9
### Deprecated
### Removed
### Fixed
- Remove accidentally duplicated lines, and fix typos in CHANGELOG.md
- point badge to the correct workflow for Ruby 2.3 (caboose.yml)
### Security

[gh!669]: https://github.com/ruby-oauth/oauth2/pull/669
[GHA-continue-on-error-ui]: https://github.com/actions/runner/issues/2347
[GHA-allow-failure]: https://github.com/orgs/community/discussions/15452

## [2.0.14] - 2025-08-31
- TAG: [v2.0.14][2.0.14t]
- COVERAGE: 100.00% -- 519/519 lines in 14 files
- BRANCH COVERAGE: 100.00% -- 174/174 branches in 14 files
- 90.48% documented
### Added
- improved documentation by @pboling
- [gh!665][gh!665] - Document Mutual TLS (mTLS) usage with example in README (connection_opts.ssl client_cert/client_key and auth_scheme: :tls_client_auth) by @pboling
- [gh!666][gh!666] - Document usage of flat query params using Faraday::FlatParamsEncoder, with example URI, in README by @pboling
  - Spec: verify flat params are preserved with Faraday::FlatParamsEncoder (skips on Faraday without FlatParamsEncoder)
- [gh!662][gh!662] - documentation notes in code comments and README highlighting OAuth 2.1 differences, with references, by @pboling
  - PKCE required for auth code,
  - exact redirect URI match,
  - implicit/password grants omitted,
  - avoid bearer tokens in query,
  - refresh token guidance for public clients,
  - simplified client definitions
- [gh!663][gh!663] - document how to implement an OIDC client with this gem in OIDC.md by @pboling
  - also, list libraries built on top of the oauth2 gem that implement OIDC
- [gh!664][gh!664] - README: Add example for JHipster UAA (Spring Cloud) password grant, converted from Postman/Net::HTTP by @pboling

[gh!662]: https://github.com/ruby-oauth/oauth2/pull/662
[gh!663]: https://github.com/ruby-oauth/oauth2/pull/663
[gh!664]: https://github.com/ruby-oauth/oauth2/pull/664
[gh!665]: https://github.com/ruby-oauth/oauth2/pull/665
[gh!666]: https://github.com/ruby-oauth/oauth2/pull/666

## [2.0.13] - 2025-08-30
- TAG: [v2.0.13][2.0.13t]
- COVERAGE: 100.00% -- 519/519 lines in 14 files
- BRANCH COVERAGE: 100.00% -- 174/174 branches in 14 files
- 90.48% documented
### Added
- [gh!656][gh!656] - Support revocation with URL-encoded parameters
- [gh!660][gh!660] - Inline yard documentation by @pboling
- [gh!660][gh!660] - Complete RBS types documentation by @pboling
- [gh!660][gh!660]- (more) Comprehensive documentation / examples by @pboling
- [gh!657][gh!657] - Updated documentation for org-rename by @pboling
- More funding links by @Aboling0
- Documentation: Added docs/OIDC.md with OIDC 1.0 overview, example, and references
### Changed
- Upgrade Code of Conduct to Contributor Covenant 2.1 by @pboling
- [gh!660][gh!660] - Shrink post-install message by 4 lines by @pboling
### Fixed
- [gh!660][gh!660] - Links in README (including link to HEAD documentation) by @pboling
### Security

[gh!660]: https://github.com/ruby-oauth/oauth2/pull/660
[gh!657]: https://github.com/ruby-oauth/oauth2/pull/657
[gh!656]: https://github.com/ruby-oauth/oauth2/pull/656

## [2.0.12] - 2025-05-31
- TAG: [v2.0.12][2.0.12t]
- Line Coverage: 100.0% (520 / 520)
- Branch Coverage: 100.0% (174 / 174)
- 80.00% documented
### Added
- [gh!652][gh!652] - Support IETF rfc7515 JSON Web Signature - JWS by @mridang
    - Support JWT `kid` for key discovery and management
- More Documentation by @pboling
    - Documented Serialization Extensions
    - Added Gatzo.com FLOSS logo by @Aboling0, CC BY-SA 4.0
- Documentation site @ https://oauth2.galtzo.com now complete
### Changed
### Deprecated
### Removed
### Fixed
### Security

## [1.0.1] - 2025-08-24
- TAG: [v1.0.1][1.0.1t]
- COVERAGE: 100.00% -- 130/130 lines in 7 files
- BRANCH COVERAGE: 96.00% -- 48/50 branches in 7 files
- 100% documented
### Fixed
- bugfix: oopsie

## [1.0.0] - 2025-08-24
- TAG: [v1.0.0][1.0.0t]
- COVERAGE: 100.00% -- 130/130 lines in 7 files
- BRANCH COVERAGE: 96.00% -- 48/50 branches in 7 files
- 100% documented
### Added
- Initial release

[Unreleased]: https://gitlab.com/ruby-oauth/oauth2/-/compare/v1.0.0...HEAD
[1.0.0]: https://gitlab.com/ruby-oauth/oauth2/-/compare/a427c302df09cfe4253a7c8d400333f9a4c1a208...v1.0.0
[1.0.0t]: https://gitlab.com/ruby-oauth/oauth2/-/tags/v1.0.0
[1.0.1]: https://gitlab.com/ruby-oauth/oauth2/-/compare/v1.0.0...v1.0.1
[1.0.1t]: https://gitlab.com/ruby-oauth/oauth2/-/tags/v1.0.1
