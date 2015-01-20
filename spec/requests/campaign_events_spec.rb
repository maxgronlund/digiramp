require 'rails_helper'

RSpec.describe "CampaignEvents", :type => :request do
  describe "GET /campaign_events" do
    it "works! (now write some real specs)" do
      get campaign_events_path
      expect(response).to have_http_status(200)
    end
  end
end
