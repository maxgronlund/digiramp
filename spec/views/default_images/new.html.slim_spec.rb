require 'rails_helper'

RSpec.describe "default_images/new", :type => :view do
  before(:each) do
    assign(:default_image, DefaultImage.new(
      :recording_artwork => "MyString",
      :user_avatar => "MyString",
      :company_logo => "MyString"
    ))
  end

  it "renders new default_image form" do
    render

    assert_select "form[action=?][method=?]", default_images_path, "post" do

      assert_select "input#default_image_recording_artwork[name=?]", "default_image[recording_artwork]"

      assert_select "input#default_image_user_avatar[name=?]", "default_image[user_avatar]"

      assert_select "input#default_image_company_logo[name=?]", "default_image[company_logo]"
    end
  end
end
