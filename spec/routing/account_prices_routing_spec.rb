require "rails_helper"

RSpec.describe AccountPricesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/account_prices").to route_to("account_prices#index")
    end

    it "routes to #new" do
      expect(:get => "/account_prices/new").to route_to("account_prices#new")
    end

    it "routes to #show" do
      expect(:get => "/account_prices/1").to route_to("account_prices#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/account_prices/1/edit").to route_to("account_prices#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/account_prices").to route_to("account_prices#create")
    end

    it "routes to #update" do
      expect(:put => "/account_prices/1").to route_to("account_prices#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/account_prices/1").to route_to("account_prices#destroy", :id => "1")
    end

  end
end
