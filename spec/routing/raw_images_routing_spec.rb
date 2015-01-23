require "rails_helper"

RSpec.describe RawImagesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/raw_images").to route_to("raw_images#index")
    end

    it "routes to #new" do
      expect(:get => "/raw_images/new").to route_to("raw_images#new")
    end

    it "routes to #show" do
      expect(:get => "/raw_images/1").to route_to("raw_images#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/raw_images/1/edit").to route_to("raw_images#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/raw_images").to route_to("raw_images#create")
    end

    it "routes to #update" do
      expect(:put => "/raw_images/1").to route_to("raw_images#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/raw_images/1").to route_to("raw_images#destroy", :id => "1")
    end

  end
end
