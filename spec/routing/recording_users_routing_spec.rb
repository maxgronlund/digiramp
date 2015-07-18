require "rails_helper"

RSpec.describe RecordingUsersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/recording_users").to route_to("recording_users#index")
    end

    it "routes to #new" do
      expect(:get => "/recording_users/new").to route_to("recording_users#new")
    end

    it "routes to #show" do
      expect(:get => "/recording_users/1").to route_to("recording_users#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/recording_users/1/edit").to route_to("recording_users#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/recording_users").to route_to("recording_users#create")
    end

    it "routes to #update" do
      expect(:put => "/recording_users/1").to route_to("recording_users#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/recording_users/1").to route_to("recording_users#destroy", :id => "1")
    end

  end
end
