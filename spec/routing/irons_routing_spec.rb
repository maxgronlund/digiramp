require "rails_helper"

RSpec.describe IronsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/irons").to route_to("irons#index")
    end

    it "routes to #new" do
      expect(:get => "/irons/new").to route_to("irons#new")
    end

    it "routes to #show" do
      expect(:get => "/irons/1").to route_to("irons#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/irons/1/edit").to route_to("irons#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/irons").to route_to("irons#create")
    end

    it "routes to #update" do
      expect(:put => "/irons/1").to route_to("irons#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/irons/1").to route_to("irons#destroy", :id => "1")
    end

  end
end
