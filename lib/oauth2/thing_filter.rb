# frozen_string_literal: true

module OAuth2
  # Small value object for matching and filtering named things.
  #
  # Used by multiple filtering surfaces in the library, such as inspected
  # object attributes and debug-log key filtering.
  #
  # `ThingFilter` snapshots and duplicates its inputs on initialization so later
  # mutation of caller-owned arrays or strings does not affect existing filter
  # instances.
  class ThingFilter
    # Create a new filter.
    #
    # @param [Enumerable<#to_s>] things Names that should be filtered
    # @param [String] label Replacement label to use for filtered values
    #
    # The provided values are duplicated and frozen so the filter remains
    # stable for the lifetime of the object.
    def initialize(things, label:)
      @things = Array(things).map { |thing| thing.to_s.dup.freeze }.freeze
      @label = label.to_s.dup.freeze
      @pattern_source = Regexp.union(@things).source.freeze
    end

    # The configured names that should be filtered.
    #
    # @return [Array<String>]
    attr_reader :things

    # The configured replacement label.
    #
    # @return [String]
    attr_reader :label

    # True when the provided name matches any configured filter entry.
    #
    # Matching is substring-based so it works naturally with instance-variable
    # names used by `#inspect`, such as `@secret` matching `secret`.
    #
    # @param [#to_s] thing_name Candidate thing name
    # @return [Boolean]
    def filtered?(thing_name)
      thing_name_str = thing_name.to_s
      things.any? { |thing| thing_name_str.include?(thing) }
    end

    # Build a regular-expression source for the configured thing names.
    #
    # Useful when a filtering surface needs regex-based replacement rather than
    # direct name checks.
    #
    # @return [String]
    attr_reader :pattern_source
  end
end
