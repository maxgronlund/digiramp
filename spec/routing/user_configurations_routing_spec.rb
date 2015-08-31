require "rails_helper"

RSpec.describe UserConfigurationsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/user_configurations").to route_to("user_configurations#index")
    end

    it "routes to #new" do
      expect(:get => "/user_configurations/new").to route_to("user_configurations#new")
    end

    it "routes to #show" do
      expect(:get => "/user_configurations/1").to route_to("user_configurations#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/user_configurations/1/edit").to route_to("user_configurations#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/user_configurations").to route_to("user_configurations#create")
    end

    it "routes to #update" do
      expect(:put => "/user_configurations/1").to route_to("user_configurations#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/user_configurations/1").to route_to("user_configurations#destroy", :id => "1")
    end

  end
end
