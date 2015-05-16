require "rails_helper"

RSpec.describe Shop::ProductsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/shop/products").to route_to("shop/products#index")
    end

    it "routes to #new" do
      expect(:get => "/shop/products/new").to route_to("shop/products#new")
    end

    it "routes to #show" do
      expect(:get => "/shop/products/1").to route_to("shop/products#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/shop/products/1/edit").to route_to("shop/products#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/shop/products").to route_to("shop/products#create")
    end

    it "routes to #update" do
      expect(:put => "/shop/products/1").to route_to("shop/products#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/shop/products/1").to route_to("shop/products#destroy", :id => "1")
    end

  end
end
