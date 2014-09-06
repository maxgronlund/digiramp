require "rails_helper"

RSpec.describe FobarsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/fobars").to route_to("fobars#index")
    end

    it "routes to #new" do
      expect(:get => "/fobars/new").to route_to("fobars#new")
    end

    it "routes to #show" do
      expect(:get => "/fobars/1").to route_to("fobars#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/fobars/1/edit").to route_to("fobars#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/fobars").to route_to("fobars#create")
    end

    it "routes to #update" do
      expect(:put => "/fobars/1").to route_to("fobars#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/fobars/1").to route_to("fobars#destroy", :id => "1")
    end

  end
end
