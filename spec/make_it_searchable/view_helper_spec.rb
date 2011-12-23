# encoding: utf-8

class Object
  include MakeItSearchable::ViewHelper
end

describe MakeItSearchable::ViewHelper do
  before :each do
    @view = Object.new
  end
  
  it 'should toggle direction' do
    @view.toggle_direction('column_name-asc').should == "column_name-desc"
    @view.toggle_direction('asc_asc-asc').should == "asc_asc-desc"
    @view.toggle_direction('column_name-desc').should == "column_name-asc"
  end
  
  it "should do nothing to the string" do
    @view.toggle_direction('column_name').should == "column_name"
  end
  
  it 'should extract direction if column_name matches' do
    @view.get_direction("column_name", "column_name-asc").should == "asc"
    @view.get_direction("diffrent_column", "column_name-asc").should == nil
  end
end