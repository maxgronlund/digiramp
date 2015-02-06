require 'rails_helper'

RSpec.describe "cms_horizontal_links/show", :type => :view do
  before(:each) do
    @cms_horizontal_link = assign(:cms_horizontal_link, CmsHorizontalLink.create!(
      :recording => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
  end
end
