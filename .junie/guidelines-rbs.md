# Junie Project Guidelines Addendum: RBS Documentation

This repository ships RBS type signatures under `sig/` which are included in the published gem and referenced by documentation tooling.

RBS files must contain only valid RBS syntax. Do not embed Ruby code or YARD-style Ruby documentation constructs in `.rbs` files.

Requirements for RBS documentation and signatures:

- Use RBS comment style (`# ...`) for notes and documentation inside `.rbs` files.
- Do not use Ruby heredocs (`<<-DOC`, `<<~RUBY`, etc.) or any Ruby code constructs in `.rbs` files.
- Do not use Ruby metaprogramming notation like `class << self` in `.rbs`. For singleton methods, use:
  - `def self.method_name: ...`
- Do not use `extend self` or `module self` in `.rbs`. Declare singleton methods explicitly with `def self.method_name: ...`.
- Keep type aliases, interfaces, and method signatures in proper RBS form only (e.g., `def foo: (String) -> Integer`).
- If you need to document parameters or returns, place brief comments above the signature lines using `#` and keep them RBS-friendly (no `@param` / `@return` tags from YARD).

Examples:

Valid (RBS):

```
module Foo
  # Runs tasks
  def self.run: () -> void
end
```

Invalid (not allowed in .rbs):

```
# Ruby syntax – not RBS
class << self
  def run: () -> void
end

# Not supported across RBS versions; avoid in this project
module self
  def run: () -> void
end

# Heredocs or any Ruby bodies are not allowed in .rbs
def self.run: () -> void
  <<~DOC
DOC
end
```

Enforcement:
- CI and local builds may parse `.rbs` files during gem install or doc generation. Any non-RBS syntax can cause installation to fail. Keep `.rbs` clean to avoid such failures.
