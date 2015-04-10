require 'rails_helper'

RSpec.describe "AccountFeatures", :type => :request do
  describe "GET /account_features" do
    it "works! (now write some real specs)" do
      get account_features_path
      expect(response).to have_http_status(200)
    end
  end
end
