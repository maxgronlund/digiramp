require 'rails_helper'

RSpec.describe "cms_pages/show", :type => :view do
  before(:each) do
    @cms_page = assign(:cms_page, CmsPage.create!(
      :user => nil,
      :title => "Title"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Title/)
  end
end
