# AGENTS.md - Development Guide

## 🎯 Project Overview

This project is a **RubyGem** managed with the [StructuredMerge](https://github.com/structuredmerge/structuredmerge-ruby) toolchain.

**Minimum Supported Ruby**: See the gemspec `required_ruby_version` constraint.
**Local Development Ruby**: See `mise.toml` for the version used in local development (typically the latest stable Ruby).

### Modular Gemfile Architecture

Gemfiles are split into modular components under `gemfiles/modular/`. Each component handles a specific concern (coverage, style, debug, etc.). The main `Gemfile` loads these modular components via `eval_gemfile`.
Gemfiles in the project, including modular ones, can utilize a `*_local.gemfile` counterpart pattern enabled via an ENV flag. This uses `nomono` to load sibling gems in the same workspace.

## ⚠️ AI Agent Terminal Limitations

### Use `mise` for Project Environment

**CRITICAL**: The canonical project environment lives in `mise.toml`, with local overrides in `.env.local` loaded via `dotenvy`.

⚠️ **Watch for trust prompts**: After editing `mise.toml` or `.env.local`, `mise` may require trust to be refreshed before commands can load the project environment. Until that trust step is handled, commands can appear hung or produce no output, which can look like terminal access is broken.

**Recovery rule**: If a `mise exec` command goes silent or appears hung, assume `mise trust` is the first thing to check. Recover by running:

```bash
mise trust -C /path/to/project
mise exec -C /path/to/project -- bundle exec kettle-test
```

Do this before spending time on unrelated debugging; in this workspace pattern, silent `mise` commands are usually a trust problem first.

✅ **CORRECT** — Run self-contained commands with `mise exec`:

```bash
mise exec -C /path/to/project -- bundle exec kettle-test
```

✅ **CORRECT** — If you need shell syntax first, load the environment in the same command:

```bash
eval "$(mise env -C /path/to/project -s bash)" && bundle exec kettle-test
```

❌ **WRONG** — Do not rely on a previous command changing directories:

```bash
cd /path/to/project
bundle exec rspec
```

❌ **WRONG** — A chained `cd` does not give directory-change hooks time to update the environment:

```bash
cd /path/to/project && bundle exec rspec
```

### Prefer Internal Tools Over Terminal

✅ **PREFERRED** — Use internal tools:

- `grep_search` instead of `grep` command
- `file_search` instead of `find` command
- `read_file` instead of `cat` command
- `list_dir` instead of `ls` command
- `replace_string_in_file` or `create_file` instead of `sed` / manual editing

❌ **AVOID** when possible:

- `run_in_terminal` for information gathering

Only use terminal for:

- Running tests (`bundle exec kettle-test`)
- Installing dependencies (`bundle install`)
- Simple commands that do not require much shell escaping
- Running scripts (prefer writing a script over a complicated command with shell escaping)

When you do run tests, keep the full output visible so you can inspect failures completely.

## 🏗️ Architecture

### Toolchain Dependencies

This gem is part of the **StructuredMerge** ecosystem. Key development tools:

| Tool | Purpose |
|------|---------|
| `kettle-dev` | Development dependency: Rake tasks, release tooling, CI helpers |
| `kettle-test` | Test infrastructure: RSpec helpers, stubbed_env, timecop |
| `kettle-jem` | Template management and gem scaffolding |

### Executables (from kettle-dev)

| Executable | Purpose |
|-----------|---------|
| `kettle-release` | Full gem release workflow |
| `kettle-pre-release` | Pre-release validation |
| `kettle-changelog` | Changelog generation |
| `kettle-dvcs` | DVCS (git) workflow automation |
| `kettle-commit-msg` | Commit message validation |
| `kettle-check-eof` | EOF newline validation |

## 📁 Project Structure

```
lib/
├── <gem_namespace>/           # Main library code
│   └── version.rb             # Version constant (managed by kettle-release)
spec/
├── fixtures/                  # Test fixture files (NOT auto-loaded)
├── support/
│   ├── classes/               # Helper classes for specs
│   └── shared_contexts/       # Shared RSpec contexts
├── spec_helper.rb             # RSpec configuration (loaded by .rspec)
gemfiles/
├── modular/                   # Modular Gemfile components
│   ├── coverage.gemfile       # SimpleCov dependencies
│   ├── debug.gemfile          # Debugging tools
│   ├── documentation.gemfile  # YARD/documentation
│   ├── optional.gemfile       # Optional dependencies
│   ├── rspec.gemfile          # RSpec testing
│   ├── style.gemfile          # RuboCop/linting
│   └── x_std_libs.gemfile     # Extracted stdlib gems
├── ruby_*.gemfile             # Per-Ruby-version Appraisal Gemfiles
└── Appraisal.root.gemfile     # Root Gemfile for Appraisal builds
.git-hooks/
├── commit-msg                 # Commit message validation hook
├── prepare-commit-msg         # Commit message preparation
├── commit-subjects-goalie.txt # Commit subject prefix filters
└── footer-template.erb.txt    # Commit footer ERB template
```

## 🔧 Development Workflows

### Running Commands

Always make commands self-contained. Use `mise exec -C /home/pboling/src/kettle-rb/prism-merge -- ...` so the command gets the project environment in the same invocation.
If the command is complicated write a script in local tmp/ and then run the script.

### Running Tests

**Always run specs via `kettle-test`** (provided by `kettle-test`). It runs `bundle exec rspec`,
captures all output to `tmp/kettle-test/rspec-TIMESTAMP.log`, and prints a structured highlight block:
timing, seed, pass/fail count, failing examples, and SimpleCov coverage percentages.

Full suite:

```bash
mise exec -C /path/to/project -- bundle exec kettle-test
```

For single file, targeted, or partial spec runs the coverage threshold **must** be disabled.
Use the `K_SOUP_COV_MIN_HARD=false` environment variable to disable hard failure:

```bash
mise exec -C /path/to/project -- env K_SOUP_COV_MIN_HARD=false bundle exec kettle-test spec/path/to/spec.rb
```

### Template Management (kettle-jem)

Run the full kettle-jem installer to sync project files with the latest template
and regenerate local finishing artifacts such as binstubs:

```bash
# Standard run (quiet, non-interactive — the default)
mise exec -C /path/to/project -- env K_JEM_TEMPLATING=true bundle exec kettle-jem install

# Verbose output (see per-file detail)
mise exec -C /path/to/project -- env K_JEM_TEMPLATING=true KETTLE_JEM_VERBOSE=true bundle exec kettle-jem install

# Interactive mode (prompt before each change)
mise exec -C /path/to/project -- env K_JEM_TEMPLATING=true bundle exec kettle-jem install --interactive

# Scoped file update only; skips install finishing steps
mise exec -C /path/to/project -- env K_JEM_TEMPLATING=true bundle exec kettle-jem template --only README.md
```

Use the `kettle-jem` executable as the public entrypoint. The
`kettle:jem:*` rake tasks are internal orchestration targets that the
executable may call after it has prepared the templating environment.

**Current defaults** (no flags needed):
- **quiet=true** — only phase summary lines shown; use `--verbose` or `KETTLE_JEM_VERBOSE=true` to opt out
- **force=true** — non-interactive; use `--interactive` to opt out
- **allowed=true** — env file changes auto-accepted; set `allowed=false` to require review

### Building & Installing Locally

To test local code changes across sibling repos, rebuild and reinstall the gem:

```bash
cd /path/to/gem && rm -rf *.gem && SKIP_GEM_SIGNING=true gem build *.gemspec && gem install --force *.gem
```

- `SKIP_GEM_SIGNING=true` bypasses the PEM passphrase prompt for signed gemspecs.
- `--force` overwrites the currently installed version.
- Always rebuild **and** reinstall before verifying cross-repo behaviour.

### Coverage Reports

```bash
mise exec -C /path/to/project -- bin/rake coverage
mise exec -C /path/to/project -- bin/kettle-soup-cover -d
```

**Key ENV variables** (set in `mise.toml`, with local overrides in `.env.local`):
- `K_SOUP_COV_DO=true` – Enable coverage
- `K_SOUP_COV_MIN_LINE` – Line coverage threshold
- `K_SOUP_COV_MIN_BRANCH` – Branch coverage threshold
- `K_SOUP_COV_MIN_HARD=true` – Fail if thresholds not met

### Code Quality

```bash
mise exec -C /path/to/project -- bundle exec rake reek
mise exec -C /path/to/project -- bundle exec rubocop-gradual
```

### Releasing

```bash
bin/kettle-pre-release    # Validate everything before release
bin/kettle-release        # Full release workflow
```

## 📝 Project Conventions

### Freeze Block Preservation

Template updates preserve custom code wrapped in freeze blocks:

```ruby
# kettle-jem:freeze
# ... custom code preserved across template runs ...
# kettle-jem:unfreeze
```

### Modular Gemfile Architecture

Gemfiles are split into modular components under `gemfiles/modular/`. Each component handles a specific concern (coverage, style, debug, etc.). The main `Gemfile` loads these modular components via `eval_gemfile`.

### Forward Compatibility with `**options`

**CRITICAL**: All constructors and public API methods that accept keyword arguments MUST include `**options` as the final parameter for forward compatibility.

## 🧪 Testing Patterns

### Test Infrastructure

- Uses `kettle-test` for RSpec helpers (stubbed_env, block_is_expected, silent_stream, timecop)
- Uses `Dir.mktmpdir` for isolated filesystem tests
- Spec helper is loaded by `.rspec` — never add `require "spec_helper"` to spec files

### Environment Variable Helpers

```ruby
before do
  stub_env("MY_ENV_VAR" => "value")
end

before do
  hide_env("HOME", "USER")
end
```

### Dependency Tags

Use dependency tags to conditionally skip tests when optional dependencies are not available:

```ruby
RSpec.describe SomeClass, :prism_merge do
  # Skipped if prism-merge is not available
end
```

## 🚫 Common Pitfalls

1. **NEVER pipe test output through `head`/`tail`** — Run tests without truncation so you can inspect the full output.
2. **README.md is mostly auto-generated by kettle-jem** — Only the following sections may be edited by hand or by agents:
   - `## 🌻 Synopsis`
   - `## ⚙️ Configuration`
   - `## 🔧 Basic Usage`

   All other sections (badges, installation, FLOSS funding, security, contributing, versioning, license, etc.) are managed by the kettle-jem template and will be overwritten on the next templating run. Do not edit them.
