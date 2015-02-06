require 'rails_helper'

RSpec.describe "cms_sections/show", :type => :view do
  before(:each) do
    @cms_section = assign(:cms_section, CmsSection.create!(
      :page => nil,
      :position => 1,
      :cms_type => "Cms Type",
      :cms_module => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Cms Type/)
    expect(rendered).to match(//)
  end
end
