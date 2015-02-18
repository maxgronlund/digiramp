require 'rails_helper'

RSpec.describe "CmsImages", :type => :request do
  describe "GET /cms_images" do
    it "works! (now write some real specs)" do
      get cms_images_path
      expect(response).to have_http_status(200)
    end
  end
end
