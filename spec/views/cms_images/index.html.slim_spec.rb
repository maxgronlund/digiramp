require 'rails_helper'

RSpec.describe "cms_images/index", :type => :view do
  before(:each) do
    assign(:cms_images, [
      CmsImage.create!(
        :image => "Image",
        :url => "Url",
        :clicks => "Clicks"
      ),
      CmsImage.create!(
        :image => "Image",
        :url => "Url",
        :clicks => "Clicks"
      )
    ])
  end

  it "renders a list of cms_images" do
    render
    assert_select "tr>td", :text => "Image".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => "Clicks".to_s, :count => 2
  end
end
