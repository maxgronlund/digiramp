require 'rails_helper'

RSpec.describe "cms_playlist_links/show", :type => :view do
  before(:each) do
    @cms_playlist_link = assign(:cms_playlist_link, CmsPlaylistLink.create!(
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
