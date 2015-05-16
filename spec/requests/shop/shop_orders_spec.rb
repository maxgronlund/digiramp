require 'rails_helper'

RSpec.describe "Shop::Orders", :type => :request do
  describe "GET /shop_orders" do
    it "works! (now write some real specs)" do
      get shop_orders_path
      expect(response).to have_http_status(200)
    end
  end
end
