require 'rails_helper'

RSpec.describe "cms_banners/new", :type => :view do
  before(:each) do
    assign(:cms_banner, CmsBanner.new(
      :image => "MyString"
    ))
  end

  it "renders new cms_banner form" do
    render

    assert_select "form[action=?][method=?]", cms_banners_path, "post" do

      assert_select "input#cms_banner_image[name=?]", "cms_banner[image]"
    end
  end
end
