require 'rails_helper'

RSpec.describe "cms_navigation_bars/edit", :type => :view do
  before(:each) do
    @cms_navigation_bar = assign(:cms_navigation_bar, CmsNavigationBar.create!())
  end

  it "renders the edit cms_navigation_bar form" do
    render

    assert_select "form[action=?][method=?]", cms_navigation_bar_path(@cms_navigation_bar), "post" do
    end
  end
end
