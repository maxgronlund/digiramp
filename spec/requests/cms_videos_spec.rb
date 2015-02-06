require 'rails_helper'

RSpec.describe "CmsVideos", :type => :request do
  describe "GET /cms_videos" do
    it "works! (now write some real specs)" do
      get cms_videos_path
      expect(response).to have_http_status(200)
    end
  end
end
