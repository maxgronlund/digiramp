require 'rails_helper'

RSpec.describe "ProUserSubscribtions", :type => :request do
  describe "GET /pro_user_subscribtions" do
    it "works! (now write some real specs)" do
      get pro_user_subscribtions_path
      expect(response).to have_http_status(200)
    end
  end
end
