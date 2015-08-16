require "rails_helper"

RSpec.describe PublishingAgreementsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/publishing_agreements").to route_to("publishing_agreements#index")
    end

    it "routes to #new" do
      expect(:get => "/publishing_agreements/new").to route_to("publishing_agreements#new")
    end

    it "routes to #show" do
      expect(:get => "/publishing_agreements/1").to route_to("publishing_agreements#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/publishing_agreements/1/edit").to route_to("publishing_agreements#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/publishing_agreements").to route_to("publishing_agreements#create")
    end

    it "routes to #update" do
      expect(:put => "/publishing_agreements/1").to route_to("publishing_agreements#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/publishing_agreements/1").to route_to("publishing_agreements#destroy", :id => "1")
    end

  end
end
