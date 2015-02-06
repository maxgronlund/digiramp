require 'rails_helper'

RSpec.describe "cms_playlist_links/new", :type => :view do
  before(:each) do
    assign(:cms_playlist_link, CmsPlaylistLink.new(
      :position => 1,
      :playlist => nil
    ))
  end

  it "renders new cms_playlist_link form" do
    render

    assert_select "form[action=?][method=?]", cms_playlist_links_path, "post" do

      assert_select "input#cms_playlist_link_position[name=?]", "cms_playlist_link[position]"

      assert_select "input#cms_playlist_link_playlist_id[name=?]", "cms_playlist_link[playlist_id]"
    end
  end
end
