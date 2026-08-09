# Security Policy

## Supported Versions

| Version  | Supported |
|----------|-----------|
| 2.0.latest | ✅         |

## Security contact information

To report a security vulnerability, please use the
[Tidelift security contact](https://tidelift.com/security).
Tidelift will coordinate the fix and disclosure.

## Additional Support

If you are interested in support for versions older than the latest release,
please consider sponsoring the project / maintainer @ https://liberapay.com/pboling/donate,
or find other sponsorship links in the [README].

[README]: README.md

## Redirect credential protection

The OAuth2 client does not require HTTP redirects for OAuth protocol
interoperability. OAuth 2.0 requires HTTPS and `POST` for token requests
([RFC 6749, §3.2](https://www.rfc-editor.org/rfc/rfc6749.html#section-3.2)); it
does not require a client to follow a server-provided redirect from that
endpoint. The OAuth 2.0 Security BCP requires authorization servers to avoid
forwarding credentials when redirecting potentially credential-bearing requests
([RFC 9700, §2.1](https://www.rfc-editor.org/rfc/rfc9700.html#section-2.1)) and
documents the body-preserving risk of HTTP 307
([RFC 9700, §4.12](https://www.rfc-editor.org/rfc/rfc9700.html#section-4.12)).
The current OAuth 2.1 draft has the corresponding HTTP 307 restriction in
§7.5.3 ([draft-ietf-oauth-v2-1-15](https://datatracker.ietf.org/doc/html/draft-ietf-oauth-v2-1-15#section-7.5.3)).
For bearer tokens, the OAuth 2.0 bearer-token specification prefers the
`Authorization` header and warns that URI query transport is likely to be
logged ([RFC 6750, §§2.1 and 2.3](https://www.rfc-editor.org/rfc/rfc6750.html#section-2.3)).

GHSA-h4fh-g8xf-8255 identified that the prior oauth2 redirect fix removed only
the `Authorization` header. Request bodies and query parameters could still be
replayed to an attacker-controlled cross-origin `Location`, including passwords,
client secrets, authorization codes, refresh tokens, revocation tokens, and
bearer tokens.

The patch release introduces `allow_cross_origin_redirects`. It defaults to
`true` for compatibility, but setting it to `false` rejects cross-origin
redirects before replaying the request. The next minor release will default it
to `false`; applications requiring the legacy behavior must explicitly opt out
with `allow_cross_origin_redirects: true`.
