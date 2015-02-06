require 'rails_helper'

RSpec.describe "cms_banners/edit", :type => :view do
  before(:each) do
    @cms_banner = assign(:cms_banner, CmsBanner.create!(
      :image => "MyString"
    ))
  end

  it "renders the edit cms_banner form" do
    render

    assert_select "form[action=?][method=?]", cms_banner_path(@cms_banner), "post" do

      assert_select "input#cms_banner_image[name=?]", "cms_banner[image]"
    end
  end
end
