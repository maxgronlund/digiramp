require 'rails_helper'

RSpec.describe "page_styles/new", :type => :view do
  before(:each) do
    assign(:page_style, PageStyle.new(
      :title => "MyString",
      :css_tag => "MyString",
      :backdrop_image => "MyString",
      :show_backdrop => "MyString",
      :bgcolor => "MyString"
    ))
  end

  it "renders new page_style form" do
    render

    assert_select "form[action=?][method=?]", page_styles_path, "post" do

      assert_select "input#page_style_title[name=?]", "page_style[title]"

      assert_select "input#page_style_css_tag[name=?]", "page_style[css_tag]"

      assert_select "input#page_style_backdrop_image[name=?]", "page_style[backdrop_image]"

      assert_select "input#page_style_show_backdrop[name=?]", "page_style[show_backdrop]"

      assert_select "input#page_style_bgcolor[name=?]", "page_style[bgcolor]"
    end
  end
end
