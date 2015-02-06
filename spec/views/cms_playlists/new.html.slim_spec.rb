require 'rails_helper'

RSpec.describe "cms_playlists/new", :type => :view do
  before(:each) do
    assign(:cms_playlist, CmsPlaylist.new(
      :position => 1,
      :playlist => nil
    ))
  end

  it "renders new cms_playlist form" do
    render

    assert_select "form[action=?][method=?]", cms_playlists_path, "post" do

      assert_select "input#cms_playlist_position[name=?]", "cms_playlist[position]"

      assert_select "input#cms_playlist_playlist_id[name=?]", "cms_playlist[playlist_id]"
    end
  end
end
