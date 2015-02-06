require 'rails_helper'

RSpec.describe "cms_banners/show", :type => :view do
  before(:each) do
    @cms_banner = assign(:cms_banner, CmsBanner.create!(
      :image => "Image"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Image/)
  end
end
