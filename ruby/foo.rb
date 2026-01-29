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
    @element = nil
    @users = []
  end

  def start_element(name, attrs)
    @element = name

    case name
    when 'user'
      @user = {
        gender: attrs.to_h['gender']
      }
    end
  end

  def end_element(name)
    @element = nil

    case name
    when 'user'
      @users << @user
      @user = nil
    end
  end

  def characters(str)
    case @element
    when 'name'
      @user[:name] = str
    when 'age'
      @user[:age] = str.to_i
    end
  end

  def results
    @users
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
