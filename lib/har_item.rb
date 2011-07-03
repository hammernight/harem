require 'mongo'

class HarItem
  attr_accessor :json, :table

  def parse_and_insert_into_database(performance_data_from_browser)
    @table.insert JSON.parse(performance_data_from_browser)
  end

  def initialize
    @conn = Mongo::Connection.new
    @db = @conn['performance']
    @table = @db['har_item']
  end
end