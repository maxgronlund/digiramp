require 'rails_helper'

RSpec.describe "cms_navigation_bars/new", :type => :view do
  before(:each) do
    assign(:cms_navigation_bar, CmsNavigationBar.new())
  end

  it "renders new cms_navigation_bar form" do
    render

    assert_select "form[action=?][method=?]", cms_navigation_bars_path, "post" do
    end
  end
end
