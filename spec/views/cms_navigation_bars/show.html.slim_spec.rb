require 'rails_helper'

RSpec.describe "cms_navigation_bars/show", :type => :view do
  before(:each) do
    @cms_navigation_bar = assign(:cms_navigation_bar, CmsNavigationBar.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
