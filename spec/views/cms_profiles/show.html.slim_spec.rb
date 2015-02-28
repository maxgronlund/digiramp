require 'rails_helper'

RSpec.describe "cms_profiles/show", :type => :view do
  before(:each) do
    @cms_profile = assign(:cms_profile, CmsProfile.create!(
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
  end
end
