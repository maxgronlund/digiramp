require 'rails_helper'

RSpec.describe "default_images/edit", :type => :view do
  before(:each) do
    @default_image = assign(:default_image, DefaultImage.create!(
      :recording_artwork => "MyString",
      :user_avatar => "MyString",
      :company_logo => "MyString"
    ))
  end

  it "renders the edit default_image form" do
    render

    assert_select "form[action=?][method=?]", default_image_path(@default_image), "post" do

      assert_select "input#default_image_recording_artwork[name=?]", "default_image[recording_artwork]"

      assert_select "input#default_image_user_avatar[name=?]", "default_image[user_avatar]"

      assert_select "input#default_image_company_logo[name=?]", "default_image[company_logo]"
    end
  end
end
