require "rails_helper"

RSpec.describe PublishingDealsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/publishing_deals").to route_to("publishing_deals#index")
    end

    it "routes to #new" do
      expect(:get => "/publishing_deals/new").to route_to("publishing_deals#new")
    end

    it "routes to #show" do
      expect(:get => "/publishing_deals/1").to route_to("publishing_deals#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/publishing_deals/1/edit").to route_to("publishing_deals#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/publishing_deals").to route_to("publishing_deals#create")
    end

    it "routes to #update" do
      expect(:put => "/publishing_deals/1").to route_to("publishing_deals#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/publishing_deals/1").to route_to("publishing_deals#destroy", :id => "1")
    end

  end
end
