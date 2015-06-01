require 'rails_helper'

RSpec.describe "Shop::PhysicalProducts", type: :request do
  describe "GET /shop_physical_products" do
    it "works! (now write some real specs)" do
      get shop_physical_products_path
      expect(response).to have_http_status(200)
    end
  end
end
