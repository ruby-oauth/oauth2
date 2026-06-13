# frozen_string_literal: true

require "set"
require "multi_xml"

(defined?(MultiXML) ? MultiXML : MultiXml).parser = :rexml
