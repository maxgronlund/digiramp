require 'rails_helper'

RSpec.describe "cms_navigation_bars/index", :type => :view do
  before(:each) do
    assign(:cms_navigation_bars, [
      CmsNavigationBar.create!(),
      CmsNavigationBar.create!()
    ])
  end

  it "renders a list of cms_navigation_bars" do
    render
  end
end
