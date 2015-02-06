require 'rails_helper'

RSpec.describe "cms_vertical_links/index", :type => :view do
  before(:each) do
    assign(:cms_vertical_links, [
      CmsVerticalLink.create!(
        :recording => nil
      ),
      CmsVerticalLink.create!(
        :recording => nil
      )
    ])
  end

  it "renders a list of cms_vertical_links" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
