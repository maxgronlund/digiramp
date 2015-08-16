require 'rails_helper'

RSpec.describe "PublishingDeals", type: :request do
  describe "GET /publishing_deals" do
    it "works! (now write some real specs)" do
      get publishing_deals_path
      expect(response).to have_http_status(200)
    end
  end
end
