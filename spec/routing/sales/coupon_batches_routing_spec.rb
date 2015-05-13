require "rails_helper"

RSpec.describe Sales::CouponBatchesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/sales/coupon_batches").to route_to("sales/coupon_batches#index")
    end

    it "routes to #new" do
      expect(:get => "/sales/coupon_batches/new").to route_to("sales/coupon_batches#new")
    end

    it "routes to #show" do
      expect(:get => "/sales/coupon_batches/1").to route_to("sales/coupon_batches#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/sales/coupon_batches/1/edit").to route_to("sales/coupon_batches#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/sales/coupon_batches").to route_to("sales/coupon_batches#create")
    end

    it "routes to #update" do
      expect(:put => "/sales/coupon_batches/1").to route_to("sales/coupon_batches#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/sales/coupon_batches/1").to route_to("sales/coupon_batches#destroy", :id => "1")
    end

  end
end
