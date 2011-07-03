require File.expand_path('../sharecare/lib/har_item')
require "rspec"
require "selenium-webdriver"

def fixture_file(file)
  File.open(File.join(File.dirname(__FILE__), 'fixtures', file), 'r:utf-8').read
end