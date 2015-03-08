require 'rails_helper'

RSpec.describe "cms_images/edit", :type => :view do
  before(:each) do
    @cms_image = assign(:cms_image, CmsImage.create!(
      :image => "MyString",
      :url => "MyString",
      :clicks => "MyString"
    ))
  end

  it "renders the edit cms_image form" do
    render

    assert_select "form[action=?][method=?]", cms_image_path(@cms_image), "post" do

      assert_select "input#cms_image_image[name=?]", "cms_image[image]"

      assert_select "input#cms_image_url[name=?]", "cms_image[url]"

      assert_select "input#cms_image_clicks[name=?]", "cms_image[clicks]"
    end
  end
end
