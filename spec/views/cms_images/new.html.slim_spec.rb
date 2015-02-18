require 'rails_helper'

RSpec.describe "cms_images/new", :type => :view do
  before(:each) do
    assign(:cms_image, CmsImage.new(
      :image => "MyString",
      :url => "MyString",
      :clicks => "MyString"
    ))
  end

  it "renders new cms_image form" do
    render

    assert_select "form[action=?][method=?]", cms_images_path, "post" do

      assert_select "input#cms_image_image[name=?]", "cms_image[image]"

      assert_select "input#cms_image_url[name=?]", "cms_image[url]"

      assert_select "input#cms_image_clicks[name=?]", "cms_image[clicks]"
    end
  end
end
