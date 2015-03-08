require 'rails_helper'

RSpec.describe "cms_playlists/show", :type => :view do
  before(:each) do
    @cms_playlist = assign(:cms_playlist, CmsPlaylist.create!(
      :position => 1,
      :playlist => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(//)
  end
end
