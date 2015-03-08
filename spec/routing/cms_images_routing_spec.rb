require "rails_helper"

RSpec.describe CmsImagesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/cms_images").to route_to("cms_images#index")
    end

    it "routes to #new" do
      expect(:get => "/cms_images/new").to route_to("cms_images#new")
    end

    it "routes to #show" do
      expect(:get => "/cms_images/1").to route_to("cms_images#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/cms_images/1/edit").to route_to("cms_images#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/cms_images").to route_to("cms_images#create")
    end

    it "routes to #update" do
      expect(:put => "/cms_images/1").to route_to("cms_images#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/cms_images/1").to route_to("cms_images#destroy", :id => "1")
    end

  end
end
