require 'rails_helper'

RSpec.describe "DigirampAds", :type => :request do
  describe "GET /digiramp_ads" do
    it "works! (now write some real specs)" do
      get digiramp_ads_path
      expect(response).to have_http_status(200)
    end
  end
end
