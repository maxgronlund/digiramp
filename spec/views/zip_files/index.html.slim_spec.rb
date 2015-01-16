require 'rails_helper'

RSpec.describe "zip_files/index", :type => :view do
  before(:each) do
    assign(:zip_files, [
      ZipFile.create!(
        :title => "Title",
        :body => "MyText",
        :zip_file => "Zip File"
      ),
      ZipFile.create!(
        :title => "Title",
        :body => "MyText",
        :zip_file => "Zip File"
      )
    ])
  end

  it "renders a list of zip_files" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Zip File".to_s, :count => 2
  end
end
