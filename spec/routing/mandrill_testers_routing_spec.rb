require "rails_helper"

RSpec.describe MandrillTestersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/mandrill_testers").to route_to("mandrill_testers#index")
    end

    it "routes to #new" do
      expect(:get => "/mandrill_testers/new").to route_to("mandrill_testers#new")
    end

    it "routes to #show" do
      expect(:get => "/mandrill_testers/1").to route_to("mandrill_testers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/mandrill_testers/1/edit").to route_to("mandrill_testers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/mandrill_testers").to route_to("mandrill_testers#create")
    end

    it "routes to #update" do
      expect(:put => "/mandrill_testers/1").to route_to("mandrill_testers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/mandrill_testers/1").to route_to("mandrill_testers#destroy", :id => "1")
    end

  end
end
