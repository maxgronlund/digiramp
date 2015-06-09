require "rails_helper"

RSpec.describe PlaylistEmailsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/playlist_emails").to route_to("playlist_emails#index")
    end

    it "routes to #new" do
      expect(:get => "/playlist_emails/new").to route_to("playlist_emails#new")
    end

    it "routes to #show" do
      expect(:get => "/playlist_emails/1").to route_to("playlist_emails#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/playlist_emails/1/edit").to route_to("playlist_emails#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/playlist_emails").to route_to("playlist_emails#create")
    end

    it "routes to #update" do
      expect(:put => "/playlist_emails/1").to route_to("playlist_emails#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/playlist_emails/1").to route_to("playlist_emails#destroy", :id => "1")
    end

  end
end
