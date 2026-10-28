# frozen_string_literal: true

# Duel's configuration: https://github.com/sferik/duel-ruby/blob/main/docs/configuration.md
#
# Duel follows conventions, so set only what differs: benchmarks are in
# duel/**/*_duel.rb, each version's lib/ is first on the load path, a
# change is compared when it touches lib/ or ext/ (or the benchmarks, this
# file, or the version files), and releases are tagged v*.
#
# kettle-jem creates this file when it is missing, and leaves it alone
# after that, so it is this project's to change.
Duel.configure do |c|
  # Each version runs on the Ruby that its own version file names, so a
  # branch that upgrades Ruby is compared on each version's own Ruby.
  c.ruby = :version_file
  # Compare a change to the Perf workflow too, which decides how the code
  # is measured. (Duel already watches lib/, ext/, the benchmarks, this
  # file, and the version files.)
  c.watch += %w[.github/workflows/perf.yml]

  # When the workflow comments on a pull request with the report: :always,
  # :results (passed or failed), :failures (failed, or couldn't compare),
  # or :never.
  # c.comment = :failures
end
