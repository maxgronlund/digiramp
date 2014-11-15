require 'rails_helper'

RSpec.describe "default_images/index", :type => :view do
  before(:each) do
    assign(:default_images, [
      DefaultImage.create!(
        :recording_artwork => "Recording Artwork",
        :user_avatar => "User Avatar",
        :company_logo => "Company Logo"
      ),
      DefaultImage.create!(
        :recording_artwork => "Recording Artwork",
        :user_avatar => "User Avatar",
        :company_logo => "Company Logo"
      )
    ])
  end

  it "renders a list of default_images" do
    render
    assert_select "tr>td", :text => "Recording Artwork".to_s, :count => 2
    assert_select "tr>td", :text => "User Avatar".to_s, :count => 2
    assert_select "tr>td", :text => "Company Logo".to_s, :count => 2
  end
end
