require 'rails_helper'

RSpec.describe "RawImages", :type => :request do
  describe "GET /raw_images" do
    it "works! (now write some real specs)" do
      get raw_images_path
      expect(response).to have_http_status(200)
    end
  end
end
