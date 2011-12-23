# encoding: utf-8

require 'spec_helper'

describe MakeItSearchable do
  it 'should extract column name and option from a string' do
    MakeItSearchable._extract_column_name_and_query_option("region_id-gt").should == ['region_id', 'gt']
    MakeItSearchable._extract_column_name_and_query_option("region_id-eq").should == ['region_id', 'eq']
    MakeItSearchable._extract_column_name_and_query_option("my_column_name-asc").should == ['my_column_name', 'asc']
    MakeItSearchable._extract_column_name_and_query_option("my_column_name").should == ['my_column_name', nil]
  end
end
