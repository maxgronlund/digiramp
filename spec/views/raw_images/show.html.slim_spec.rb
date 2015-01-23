require 'rails_helper'

RSpec.describe "raw_images/show", :type => :view do
  before(:each) do
    @raw_image = assign(:raw_image, RawImage.create!(
      :identifier => "Identifier",
      :title => "Title",
      :image => "Image"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Identifier/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Image/)
  end
end
