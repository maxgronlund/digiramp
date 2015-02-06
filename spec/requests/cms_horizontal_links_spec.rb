require 'rails_helper'

RSpec.describe "CmsHorizontalLinks", :type => :request do
  describe "GET /cms_horizontal_links" do
    it "works! (now write some real specs)" do
      get cms_horizontal_links_path
      expect(response).to have_http_status(200)
    end
  end
end
