require "rails_helper"

RSpec.describe DefaultImagesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/default_images").to route_to("default_images#index")
    end

    it "routes to #new" do
      expect(:get => "/default_images/new").to route_to("default_images#new")
    end

    it "routes to #show" do
      expect(:get => "/default_images/1").to route_to("default_images#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/default_images/1/edit").to route_to("default_images#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/default_images").to route_to("default_images#create")
    end

    it "routes to #update" do
      expect(:put => "/default_images/1").to route_to("default_images#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/default_images/1").to route_to("default_images#destroy", :id => "1")
    end

  end
end
