require 'rails_helper'

RSpec.describe "AmazonSns", :type => :request do
  describe "GET /amazon_sns" do
    it "works! (now write some real specs)" do
      get amazon_sns_path
      expect(response).to have_http_status(200)
    end
  end
end
