require 'rails_helper'

RSpec.describe "cms_vertical_links/show", :type => :view do
  before(:each) do
    @cms_vertical_link = assign(:cms_vertical_link, CmsVerticalLink.create!(
      :recording => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
  end
end
