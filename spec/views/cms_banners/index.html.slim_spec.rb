require 'rails_helper'

RSpec.describe "cms_banners/index", :type => :view do
  before(:each) do
    assign(:cms_banners, [
      CmsBanner.create!(
        :image => "Image"
      ),
      CmsBanner.create!(
        :image => "Image"
      )
    ])
  end

  it "renders a list of cms_banners" do
    render
    assert_select "tr>td", :text => "Image".to_s, :count => 2
  end
end
