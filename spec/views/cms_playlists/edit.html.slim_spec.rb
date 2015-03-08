require 'rails_helper'

RSpec.describe "cms_playlists/edit", :type => :view do
  before(:each) do
    @cms_playlist = assign(:cms_playlist, CmsPlaylist.create!(
      :position => 1,
      :playlist => nil
    ))
  end

  it "renders the edit cms_playlist form" do
    render

    assert_select "form[action=?][method=?]", cms_playlist_path(@cms_playlist), "post" do

      assert_select "input#cms_playlist_position[name=?]", "cms_playlist[position]"

      assert_select "input#cms_playlist_playlist_id[name=?]", "cms_playlist[playlist_id]"
    end
  end
end
