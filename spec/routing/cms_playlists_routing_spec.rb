require "rails_helper"

RSpec.describe CmsPlaylistsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/cms_playlists").to route_to("cms_playlists#index")
    end

    it "routes to #new" do
      expect(:get => "/cms_playlists/new").to route_to("cms_playlists#new")
    end

    it "routes to #show" do
      expect(:get => "/cms_playlists/1").to route_to("cms_playlists#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/cms_playlists/1/edit").to route_to("cms_playlists#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/cms_playlists").to route_to("cms_playlists#create")
    end

    it "routes to #update" do
      expect(:put => "/cms_playlists/1").to route_to("cms_playlists#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/cms_playlists/1").to route_to("cms_playlists#destroy", :id => "1")
    end

  end
end
