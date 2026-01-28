require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'irb'
  gem 'nokogiri'
end

require 'irb'
require 'nokogiri'

xml = <<~XML
  <users>
    <user gender="male">
      <name>John Doe</name>
      <age>30</age>
    </user>

    <user gender="female">
      <name>Jane Smith</name>
      <age>25</age>
    </user>
  </users>
XML

class Document < Nokogiri::XML::SAX::Document
  def initialize
    @group   = []
    @outputs = []
  end

  attr_accessor :group, :outputs

  def start_element(name, attrs)
    @group << name if name == 'name' || name == 'age'
    @group << attrs if attrs.length > 0
  end

  def end_element(name)
    if name == 'user'
      @outputs << @group.flatten
      @group = []
    end
  end

  def characters(str)
    @group << str.strip if str.strip.length > 0
  end

  def results
    @outputs.map {|group|
      group.each_slice(2).each_with_object(Hash.new) {|i, h|
        h[i.first.to_sym] = i.last
      }
    }
  end
end

doc = Document.new

Nokogiri::XML::SAX::Parser.new(doc).parse xml

pp doc.results
# Expected output:
# [
#  { name: "John Doe",   age: 30, gender: "male" },
#  { name: "Jane Smith", age: 25, gender: "female" }
# ]
