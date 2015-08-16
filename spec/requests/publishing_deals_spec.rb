require 'rails_helper'

RSpec.describe "PublishingAgreements", type: :request do
  describe "GET /publishing_agreements" do
    it "works! (now write some real specs)" do
      get publishing_agreements_path
      expect(response).to have_http_status(200)
    end
  end
end
