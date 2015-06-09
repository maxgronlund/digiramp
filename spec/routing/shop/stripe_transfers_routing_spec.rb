require "rails_helper"

RSpec.describe Shop::StripeTransfersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/shop/stripe_transfers").to route_to("shop/stripe_transfers#index")
    end

    it "routes to #new" do
      expect(:get => "/shop/stripe_transfers/new").to route_to("shop/stripe_transfers#new")
    end

    it "routes to #show" do
      expect(:get => "/shop/stripe_transfers/1").to route_to("shop/stripe_transfers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/shop/stripe_transfers/1/edit").to route_to("shop/stripe_transfers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/shop/stripe_transfers").to route_to("shop/stripe_transfers#create")
    end

    it "routes to #update" do
      expect(:put => "/shop/stripe_transfers/1").to route_to("shop/stripe_transfers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/shop/stripe_transfers/1").to route_to("shop/stripe_transfers#destroy", :id => "1")
    end

  end
end
