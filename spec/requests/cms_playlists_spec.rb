require 'rails_helper'

RSpec.describe "CmsPlaylists", :type => :request do
  describe "GET /cms_playlists" do
    it "works! (now write some real specs)" do
      get cms_playlists_path
      expect(response).to have_http_status(200)
    end
  end
end
