require 'rails_helper'

RSpec.describe "cms_videos/index", :type => :view do
  before(:each) do
    assign(:cms_videos, [
      CmsVideo.create!(
        :position => 1,
        :snippet => "MyText"
      ),
      CmsVideo.create!(
        :position => 1,
        :snippet => "MyText"
      )
    ])
  end

  it "renders a list of cms_videos" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
