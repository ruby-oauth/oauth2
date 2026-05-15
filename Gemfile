# frozen_string_literal: true

source "https://gem.coop"

git_source(:codeberg) { |repo_name| "https://codeberg.org/#{repo_name}" }
git_source(:gitlab) { |repo_name| "https://gitlab.com/#{repo_name}" }

#### IMPORTANT #######################################################
# Gemfile is for local development ONLY; Gemfile is NOT loaded in CI #
####################################################### IMPORTANT ####

# Include dependencies from <gem name>.gemspec
gemspec

unless %w[false 0 no off].include?(ENV.fetch("RUBY_OAUTH_DEV", "false").downcase)
  begin
    require "nomono/bundler" unless defined?(Nomono)
  rescue LoadError
    require_relative "../nomono/lib/nomono/bundler"
  end

  eval_nomono_gems(
    gems: %w[auth-sanitizer],
    prefix: "RUBY_OAUTH",
    path_env: "RUBY_OAUTH_DEV",
    root: %w[code src ruby-oauth],
    debug_env: "RUBY_OAUTH_DEBUG",
  )
end

# Debugging
eval_gemfile "gemfiles/modular/debug.gemfile"

# Code Coverage
eval_gemfile "gemfiles/modular/coverage.gemfile"

# Linting
eval_gemfile "gemfiles/modular/style.gemfile"

# Documentation
eval_gemfile "gemfiles/modular/documentation.gemfile"

# Optional
eval_gemfile "gemfiles/modular/optional.gemfile"

### Std Lib Extracted Gems
eval_gemfile "gemfiles/modular/x_std_libs.gemfile"
