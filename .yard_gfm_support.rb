# Gratefully and liberally taken from the MIT-licensed https://github.com/bensheldon/good_job/pull/113/files
require "kramdown"
require "kramdown-parser-gfm"

# Custom markup provider class that always renders Kramdown using GFM (Github Flavored Markdown).
# GFM is needed to render markdown tables and fenced code blocks in the README.
class KramdownGfmDocument < Kramdown::Document
  def initialize(source, options = {})
    options[:input] = "GFM" unless options.key?(:input)
    super(source, options)
  end
end

# Ensure YARD is loaded before modifying its constants
require 'yard' unless defined?(YARD)

# Insert the new provider as the highest priority option for Markdown.
# See:
# - https://github.com/lsegal/yard/issues/1157
# - https://github.com/lsegal/yard/issues/1017
# - https://github.com/lsegal/yard/blob/main/lib/yard/templates/helpers/markup_helper.rb
require 'yard/templates/helpers/markup_helper'

providers = YARD::Templates::Helpers::MarkupHelper::MARKUP_PROVIDERS[:markdown]
providers.unshift({lib: :kramdown, const: :KramdownGfmDocument})

# Normalize provider entries to what YARD expects (const must be a String)
providers.each do |provider|
  const = provider[:const]
  provider[:const] = const.to_s if const.is_a?(Symbol)
end

# De-duplicate entries by [lib, const]
providers.uniq! { |p| [p[:lib], p[:const].to_s] }
