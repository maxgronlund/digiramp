require 'rails_helper'

RSpec.describe "ShareOnTwitters", :type => :request do
  describe "GET /share_on_twitters" do
    it "works! (now write some real specs)" do
      get share_on_twitters_path
      expect(response).to have_http_status(200)
    end
  end
end
