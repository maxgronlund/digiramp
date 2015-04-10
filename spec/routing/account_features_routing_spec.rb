require "rails_helper"

RSpec.describe AccountFeaturesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/account_features").to route_to("account_features#index")
    end

    it "routes to #new" do
      expect(:get => "/account_features/new").to route_to("account_features#new")
    end

    it "routes to #show" do
      expect(:get => "/account_features/1").to route_to("account_features#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/account_features/1/edit").to route_to("account_features#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/account_features").to route_to("account_features#create")
    end

    it "routes to #update" do
      expect(:put => "/account_features/1").to route_to("account_features#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/account_features/1").to route_to("account_features#destroy", :id => "1")
    end

  end
end
