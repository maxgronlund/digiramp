require "rails_helper"

RSpec.describe CmsVerticalLinksController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/cms_vertical_links").to route_to("cms_vertical_links#index")
    end

    it "routes to #new" do
      expect(:get => "/cms_vertical_links/new").to route_to("cms_vertical_links#new")
    end

    it "routes to #show" do
      expect(:get => "/cms_vertical_links/1").to route_to("cms_vertical_links#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/cms_vertical_links/1/edit").to route_to("cms_vertical_links#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/cms_vertical_links").to route_to("cms_vertical_links#create")
    end

    it "routes to #update" do
      expect(:put => "/cms_vertical_links/1").to route_to("cms_vertical_links#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/cms_vertical_links/1").to route_to("cms_vertical_links#destroy", :id => "1")
    end

  end
end
