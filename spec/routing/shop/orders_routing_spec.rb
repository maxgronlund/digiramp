require "rails_helper"

RSpec.describe Shop::OrdersController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/shop/orders").to route_to("shop/orders#index")
    end

    it "routes to #new" do
      expect(:get => "/shop/orders/new").to route_to("shop/orders#new")
    end

    it "routes to #show" do
      expect(:get => "/shop/orders/1").to route_to("shop/orders#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/shop/orders/1/edit").to route_to("shop/orders#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/shop/orders").to route_to("shop/orders#create")
    end

    it "routes to #update" do
      expect(:put => "/shop/orders/1").to route_to("shop/orders#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/shop/orders/1").to route_to("shop/orders#destroy", :id => "1")
    end

  end
end
