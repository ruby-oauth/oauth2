#!/usr/bin/env ruby
require 'bundler/setup'
require 'yard'
require 'yard/templates/helpers/markup_helper'

puts "Before loading .yard_gfm_support.rb:"
YARD::Templates::Helpers::MarkupHelper::MARKUP_PROVIDERS[:markdown].each_with_index do |p, i|
  puts "  [#{i}] #{p.inspect}"
end

require './.yard_gfm_support.rb'

puts "\nAfter loading .yard_gfm_support.rb:"
YARD::Templates::Helpers::MarkupHelper::MARKUP_PROVIDERS[:markdown].each_with_index do |p, i|
  puts "  [#{i}] #{p.inspect}"
end

puts "\nTesting KramdownGfmDocument:"

test_md = <<-MD
  # Test

  ```ruby
  puts "hello"
  ```
MD

doc = KramdownGfmDocument.new(test_md)
html = doc.to_html
puts html
puts "\nDoes output contain <pre>? #{html.include?('<pre>')}"
puts "Does output contain <code>? #{html.include?('<code')}"
