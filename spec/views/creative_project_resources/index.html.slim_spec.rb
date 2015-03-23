require 'rails_helper'

RSpec.describe "creative_project_resources/index", :type => :view do
  before(:each) do
    assign(:creative_project_resources, [
      CreativeProjectResource.create!(
        :creative_project => nil,
        :user => nil,
        :title => "Title",
        :description => "MyText",
        :file => "File",
        :file_size => "File Size",
        :content_type => "Content Type"
      ),
      CreativeProjectResource.create!(
        :creative_project => nil,
        :user => nil,
        :title => "Title",
        :description => "MyText",
        :file => "File",
        :file_size => "File Size",
        :content_type => "Content Type"
      )
    ])
  end

  it "renders a list of creative_project_resources" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "File".to_s, :count => 2
    assert_select "tr>td", :text => "File Size".to_s, :count => 2
    assert_select "tr>td", :text => "Content Type".to_s, :count => 2
  end
end
