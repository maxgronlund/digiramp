require 'rails_helper'

RSpec.describe "CmsRecordings", :type => :request do
  describe "GET /cms_recordings" do
    it "works! (now write some real specs)" do
      get cms_recordings_path
      expect(response).to have_http_status(200)
    end
  end
end
