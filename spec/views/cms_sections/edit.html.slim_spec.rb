require 'rails_helper'

RSpec.describe "cms_sections/edit", :type => :view do
  before(:each) do
    @cms_section = assign(:cms_section, CmsSection.create!(
      :page => nil,
      :position => 1,
      :cms_type => "MyString",
      :cms_module => nil
    ))
  end

  it "renders the edit cms_section form" do
    render

    assert_select "form[action=?][method=?]", cms_section_path(@cms_section), "post" do

      assert_select "input#cms_section_page_id[name=?]", "cms_section[page_id]"

      assert_select "input#cms_section_position[name=?]", "cms_section[position]"

      assert_select "input#cms_section_cms_type[name=?]", "cms_section[cms_type]"

      assert_select "input#cms_section_cms_module_id[name=?]", "cms_section[cms_module_id]"
    end
  end
end
