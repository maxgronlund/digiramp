require 'rails_helper'

RSpec.describe "Sales::CouponBatches", :type => :request do
  describe "GET /sales_coupon_batches" do
    it "works! (now write some real specs)" do
      get sales_coupon_batches_path
      expect(response).to have_http_status(200)
    end
  end
end
