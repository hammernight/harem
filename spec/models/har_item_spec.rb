require 'spec_helper'

describe HarItem do

  context 'loading har file to a json' do
    let(:har_item){ HarItem.new }
    before do
      @database_entry = har_item.parse_and_insert_into_database(fixture_file('har.json'))
    end

    it 'is inserted into the database' do
      @database_entry.should be_a BSON::ObjectId
    end

    it 'is the same json' do
      har_item.table.find.first['log']['entries'].first['response']['status'].should == JSON.parse(fixture_file('har.json'))['log']['entries'].first['response']['status']
    end



  end
end