require "rails_helper"

RSpec.describe DigirampAdsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/digiramp_ads").to route_to("digiramp_ads#index")
    end

    it "routes to #new" do
      expect(:get => "/digiramp_ads/new").to route_to("digiramp_ads#new")
    end

    it "routes to #show" do
      expect(:get => "/digiramp_ads/1").to route_to("digiramp_ads#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/digiramp_ads/1/edit").to route_to("digiramp_ads#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/digiramp_ads").to route_to("digiramp_ads#create")
    end

    it "routes to #update" do
      expect(:put => "/digiramp_ads/1").to route_to("digiramp_ads#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/digiramp_ads/1").to route_to("digiramp_ads#destroy", :id => "1")
    end

  end
end
