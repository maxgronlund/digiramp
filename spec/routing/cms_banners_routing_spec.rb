require "rails_helper"

RSpec.describe CmsBannersController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/cms_banners").to route_to("cms_banners#index")
    end

    it "routes to #new" do
      expect(:get => "/cms_banners/new").to route_to("cms_banners#new")
    end

    it "routes to #show" do
      expect(:get => "/cms_banners/1").to route_to("cms_banners#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/cms_banners/1/edit").to route_to("cms_banners#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/cms_banners").to route_to("cms_banners#create")
    end

    it "routes to #update" do
      expect(:put => "/cms_banners/1").to route_to("cms_banners#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/cms_banners/1").to route_to("cms_banners#destroy", :id => "1")
    end

  end
end
