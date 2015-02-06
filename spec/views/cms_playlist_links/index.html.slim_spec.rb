require 'rails_helper'

RSpec.describe "cms_playlist_links/index", :type => :view do
  before(:each) do
    assign(:cms_playlist_links, [
      CmsPlaylistLink.create!(
        :position => 1,
        :playlist => nil
      ),
      CmsPlaylistLink.create!(
        :position => 1,
        :playlist => nil
      )
    ])
  end

  it "renders a list of cms_playlist_links" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
