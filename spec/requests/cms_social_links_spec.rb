require 'rails_helper'

RSpec.describe "CmsSocialLinks", :type => :request do
  describe "GET /cms_social_links" do
    it "works! (now write some real specs)" do
      get cms_social_links_path
      expect(response).to have_http_status(200)
    end
  end
end
