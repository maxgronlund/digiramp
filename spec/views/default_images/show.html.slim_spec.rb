require 'rails_helper'

RSpec.describe "default_images/show", :type => :view do
  before(:each) do
    @default_image = assign(:default_image, DefaultImage.create!(
      :recording_artwork => "Recording Artwork",
      :user_avatar => "User Avatar",
      :company_logo => "Company Logo"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Recording Artwork/)
    expect(rendered).to match(/User Avatar/)
    expect(rendered).to match(/Company Logo/)
  end
end
