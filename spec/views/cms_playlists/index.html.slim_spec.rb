require 'rails_helper'

RSpec.describe "cms_playlists/index", :type => :view do
  before(:each) do
    assign(:cms_playlists, [
      CmsPlaylist.create!(
        :position => 1,
        :playlist => nil
      ),
      CmsPlaylist.create!(
        :position => 1,
        :playlist => nil
      )
    ])
  end

  it "renders a list of cms_playlists" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
