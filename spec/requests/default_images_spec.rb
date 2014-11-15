require 'rails_helper'

RSpec.describe "DefaultImages", :type => :request do
  describe "GET /default_images" do
    it "works! (now write some real specs)" do
      get default_images_path
      expect(response).to have_http_status(200)
    end
  end
end
