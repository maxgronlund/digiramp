require 'rails_helper'

RSpec.describe "Shop::Products", :type => :request do
  describe "GET /shop_products" do
    it "works! (now write some real specs)" do
      get shop_products_path
      expect(response).to have_http_status(200)
    end
  end
end
