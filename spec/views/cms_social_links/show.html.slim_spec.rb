require 'rails_helper'

RSpec.describe "cms_social_links/show", :type => :view do
  before(:each) do
    @cms_social_link = assign(:cms_social_link, CmsSocialLink.create!(
      :position => 1,
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(//)
  end
end
