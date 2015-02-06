require 'rails_helper'

RSpec.describe "CmsPages", :type => :request do
  describe "GET /cms_pages" do
    it "works! (now write some real specs)" do
      get cms_pages_path
      expect(response).to have_http_status(200)
    end
  end
end
