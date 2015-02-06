require 'rails_helper'

RSpec.describe "cms_sections/new", :type => :view do
  before(:each) do
    assign(:cms_section, CmsSection.new(
      :page => nil,
      :position => 1,
      :cms_type => "MyString",
      :cms_module => nil
    ))
  end

  it "renders new cms_section form" do
    render

    assert_select "form[action=?][method=?]", cms_sections_path, "post" do

      assert_select "input#cms_section_page_id[name=?]", "cms_section[page_id]"

      assert_select "input#cms_section_position[name=?]", "cms_section[position]"

      assert_select "input#cms_section_cms_type[name=?]", "cms_section[cms_type]"

      assert_select "input#cms_section_cms_module_id[name=?]", "cms_section[cms_module_id]"
    end
  end
end
