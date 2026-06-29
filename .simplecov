# kettle-jem:freeze
# To retain chunks of comments & code during oauth2 templating:
# Wrap custom sections with freeze markers (e.g., as above and below this comment chunk).
# oauth2 will then preserve content between those markers across template runs.
# kettle-jem:unfreeze

# Minimum coverage thresholds are set by kettle-soup-cover.
# They are controlled by ENV variables loaded by `mise` from `mise.toml`
# (with optional machine-local overrides in `.env.local`).
# If the values for minimum coverage need to change, they should be changed both there,
#   and in 2 places in .github/workflows/coverage.yml.
SimpleCov.configure do
  cover "lib/**/*.rb", "lib/**/*.rake", "exe/*.rb"
end
# It is controlled by ENV variables, which are set in .envrc and loaded via `direnv allow`
