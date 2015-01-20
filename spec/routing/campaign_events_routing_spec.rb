require "rails_helper"

RSpec.describe CampaignEventsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/campaign_events").to route_to("campaign_events#index")
    end

    it "routes to #new" do
      expect(:get => "/campaign_events/new").to route_to("campaign_events#new")
    end

    it "routes to #show" do
      expect(:get => "/campaign_events/1").to route_to("campaign_events#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/campaign_events/1/edit").to route_to("campaign_events#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/campaign_events").to route_to("campaign_events#create")
    end

    it "routes to #update" do
      expect(:put => "/campaign_events/1").to route_to("campaign_events#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/campaign_events/1").to route_to("campaign_events#destroy", :id => "1")
    end

  end
end
