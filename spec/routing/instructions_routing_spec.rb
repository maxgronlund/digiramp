require "rails_helper"

RSpec.describe InstructionsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/instructions").to route_to("instructions#index")
    end

    it "routes to #new" do
      expect(:get => "/instructions/new").to route_to("instructions#new")
    end

    it "routes to #show" do
      expect(:get => "/instructions/1").to route_to("instructions#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/instructions/1/edit").to route_to("instructions#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/instructions").to route_to("instructions#create")
    end

    it "routes to #update" do
      expect(:put => "/instructions/1").to route_to("instructions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/instructions/1").to route_to("instructions#destroy", :id => "1")
    end

  end
end
