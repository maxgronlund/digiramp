require 'rails_helper'

RSpec.describe "BlacklistDomains", type: :request do
  describe "GET /blacklist_domains" do
    it "works! (now write some real specs)" do
      get blacklist_domains_path
      expect(response).to have_http_status(200)
    end
  end
end
