# RuboCop Usage Guide

## Overview

A tale of two RuboCop plugin gems.

### RuboCop Gradual

This project uses `rubocop_gradual` instead of vanilla RuboCop for code style checking. The `rubocop_gradual` tool allows for gradual adoption of RuboCop rules by tracking violations in a lock file.

### RuboCop LTS

This project uses `rubocop-lts` to ensure, on a best-effort basis, compatibility with Ruby >= 1.9.2.
RuboCop rules are meticulously configured by the `rubocop-lts` family of gems to ensure that a project is compatible with a specific version of Ruby. See: https://rubocop-lts.gitlab.io for more.

## Checking RuboCop Violations

To check for RuboCop violations in this project, always use:

```bash
bundle exec rake rubocop_gradual:check
```

**Do not use** the standard RuboCop commands like:
- `bundle exec rubocop`
- `rubocop`

## Understanding the Lock File

The `.rubocop_gradual.lock` file is a work list, not a permanent baseline. Every entry represents a style issue that should be resolved by either fixing the code or making an intentional exception explicit.

This allows the team to:

1. Prevent new violations while existing issues are handled deliberately
2. Track progress on code style improvements
3. Distinguish temporary work items from intentional project style exceptions

## Common Commands

- **Check violations**
    - `bundle exec rake rubocop_gradual`
    - `bundle exec rake rubocop_gradual:check`
- **(Safe) Autocorrect violations, and update lockfile if no new violations**
  - `bundle exec rake rubocop_gradual:autocorrect`
- **Force update the lock file (w/o autocorrect) to match violations present in code**
  - `bundle exec rake rubocop_gradual:force_update`

## Workflow

1. Before submitting a PR, run `bundle exec rake rubocop_gradual:autocorrect`
   a. or just the default `bundle exec rake`, as autocorrection is a pre-requisite of the default task.
2. If there are violations, either:
   - Fix them in your code
   - Normalize intentional deviations with an explicit config or inline exception
   - Run `bundle exec rake rubocop_gradual:force_update` only for temporary work items you cannot fix immediately
3. Commit the updated `.rubocop_gradual.lock` file along with your changes

## Explicit Style Exceptions

Do not treat `.rubocop_gradual.lock` as a baseline. Treat it as a list of work that must be fixed or normalized into the styleguide.

Prefer this order:

1. Fix the code so it follows the configured styleguide.
2. For intentional project conventions, add the narrowest useful override in `.rubocop.yml` or `.rubocop_rspec.yml`.
3. For local intentional deviations, add a tightly scoped inline `rubocop:disable` / `rubocop:enable` around the exact line or block.
4. Keep an entry in `.rubocop_gradual.lock` only as temporary work to be resolved later.

Use configuration overrides when a deviation is structural, generated, path-specific, or applies consistently to a small set of files. Use inline disables when the exception is local and the reason is clearer at the code site than in global config.

In general, treat the rules as guidance to follow; fix violations rather than ignore them. For example, RSpec conventions in this project expect `described_class` to be used in specs that target a specific class under test.

## Benefits of rubocop_gradual

- Allows incremental adoption of code style rules
- Prevents CI failures due to temporary pre-existing violations
- Provides a clear work list of code style debt
- Enables focused efforts on improving code quality over time
