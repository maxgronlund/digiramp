require 'rails_helper'

RSpec.describe "AccountPrices", :type => :request do
  describe "GET /account_prices" do
    it "works! (now write some real specs)" do
      get account_prices_path
      expect(response).to have_http_status(200)
    end
  end
end
