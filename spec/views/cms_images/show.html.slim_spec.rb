require 'rails_helper'

RSpec.describe "cms_images/show", :type => :view do
  before(:each) do
    @cms_image = assign(:cms_image, CmsImage.create!(
      :image => "Image",
      :url => "Url",
      :clicks => "Clicks"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Image/)
    expect(rendered).to match(/Url/)
    expect(rendered).to match(/Clicks/)
  end
end
