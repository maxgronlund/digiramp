require 'rails_helper'

RSpec.describe "cms_social_links/index", :type => :view do
  before(:each) do
    assign(:cms_social_links, [
      CmsSocialLink.create!(
        :position => 1,
        :user => nil
      ),
      CmsSocialLink.create!(
        :position => 1,
        :user => nil
      )
    ])
  end

  it "renders a list of cms_social_links" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
