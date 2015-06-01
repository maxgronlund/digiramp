require "rails_helper"

RSpec.describe Shop::PhysicalProductsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/shop/physical_products").to route_to("shop/physical_products#index")
    end

    it "routes to #new" do
      expect(:get => "/shop/physical_products/new").to route_to("shop/physical_products#new")
    end

    it "routes to #show" do
      expect(:get => "/shop/physical_products/1").to route_to("shop/physical_products#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/shop/physical_products/1/edit").to route_to("shop/physical_products#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/shop/physical_products").to route_to("shop/physical_products#create")
    end

    it "routes to #update" do
      expect(:put => "/shop/physical_products/1").to route_to("shop/physical_products#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/shop/physical_products/1").to route_to("shop/physical_products#destroy", :id => "1")
    end

  end
end
