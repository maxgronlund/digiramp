require 'rails_helper'

RSpec.describe "Shop::StripeTransfers", type: :request do
  describe "GET /shop_stripe_transfers" do
    it "works! (now write some real specs)" do
      get shop_stripe_transfers_path
      expect(response).to have_http_status(200)
    end
  end
end
