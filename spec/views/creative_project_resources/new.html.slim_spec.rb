require 'rails_helper'

RSpec.describe "creative_project_resources/new", :type => :view do
  before(:each) do
    assign(:creative_project_resource, CreativeProjectResource.new(
      :creative_project => nil,
      :user => nil,
      :title => "MyString",
      :description => "MyText",
      :file => "MyString",
      :file_size => "MyString",
      :content_type => "MyString"
    ))
  end

  it "renders new creative_project_resource form" do
    render

    assert_select "form[action=?][method=?]", creative_project_resources_path, "post" do

      assert_select "input#creative_project_resource_creative_project_id[name=?]", "creative_project_resource[creative_project_id]"

      assert_select "input#creative_project_resource_user_id[name=?]", "creative_project_resource[user_id]"

      assert_select "input#creative_project_resource_title[name=?]", "creative_project_resource[title]"

      assert_select "textarea#creative_project_resource_description[name=?]", "creative_project_resource[description]"

      assert_select "input#creative_project_resource_file[name=?]", "creative_project_resource[file]"

      assert_select "input#creative_project_resource_file_size[name=?]", "creative_project_resource[file_size]"

      assert_select "input#creative_project_resource_content_type[name=?]", "creative_project_resource[content_type]"
    end
  end
end
