require 'rails_helper'

RSpec.describe "cms_playlist_links/edit", :type => :view do
  before(:each) do
    @cms_playlist_link = assign(:cms_playlist_link, CmsPlaylistLink.create!(
      :position => 1,
      :playlist => nil
    ))
  end

  it "renders the edit cms_playlist_link form" do
    render

    assert_select "form[action=?][method=?]", cms_playlist_link_path(@cms_playlist_link), "post" do

      assert_select "input#cms_playlist_link_position[name=?]", "cms_playlist_link[position]"

      assert_select "input#cms_playlist_link_playlist_id[name=?]", "cms_playlist_link[playlist_id]"
    end
  end
end
