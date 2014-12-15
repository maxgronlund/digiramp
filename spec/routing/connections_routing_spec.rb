require "rails_helper"

RSpec.describe ConnectionsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/connections").to route_to("connections#index")
    end

    it "routes to #new" do
      expect(:get => "/connections/new").to route_to("connections#new")
    end

    it "routes to #show" do
      expect(:get => "/connections/1").to route_to("connections#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/connections/1/edit").to route_to("connections#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/connections").to route_to("connections#create")
    end

    it "routes to #update" do
      expect(:put => "/connections/1").to route_to("connections#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/connections/1").to route_to("connections#destroy", :id => "1")
    end

  end
end
