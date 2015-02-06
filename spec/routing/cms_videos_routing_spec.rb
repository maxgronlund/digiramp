require "rails_helper"

RSpec.describe CmsVideosController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/cms_videos").to route_to("cms_videos#index")
    end

    it "routes to #new" do
      expect(:get => "/cms_videos/new").to route_to("cms_videos#new")
    end

    it "routes to #show" do
      expect(:get => "/cms_videos/1").to route_to("cms_videos#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/cms_videos/1/edit").to route_to("cms_videos#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/cms_videos").to route_to("cms_videos#create")
    end

    it "routes to #update" do
      expect(:put => "/cms_videos/1").to route_to("cms_videos#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/cms_videos/1").to route_to("cms_videos#destroy", :id => "1")
    end

  end
end
