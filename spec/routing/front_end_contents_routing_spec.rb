require "rails_helper"

RSpec.describe FrontEndContentsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/front_end_contents").to route_to("front_end_contents#index")
    end

    it "routes to #new" do
      expect(:get => "/front_end_contents/new").to route_to("front_end_contents#new")
    end

    it "routes to #show" do
      expect(:get => "/front_end_contents/1").to route_to("front_end_contents#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/front_end_contents/1/edit").to route_to("front_end_contents#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/front_end_contents").to route_to("front_end_contents#create")
    end

    it "routes to #update" do
      expect(:put => "/front_end_contents/1").to route_to("front_end_contents#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/front_end_contents/1").to route_to("front_end_contents#destroy", :id => "1")
    end

  end
end
