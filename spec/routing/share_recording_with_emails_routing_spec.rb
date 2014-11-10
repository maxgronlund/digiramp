require "rails_helper"

RSpec.describe ShareRecordingWithEmailsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/share_recording_with_emails").to route_to("share_recording_with_emails#index")
    end

    it "routes to #new" do
      expect(:get => "/share_recording_with_emails/new").to route_to("share_recording_with_emails#new")
    end

    it "routes to #show" do
      expect(:get => "/share_recording_with_emails/1").to route_to("share_recording_with_emails#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/share_recording_with_emails/1/edit").to route_to("share_recording_with_emails#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/share_recording_with_emails").to route_to("share_recording_with_emails#create")
    end

    it "routes to #update" do
      expect(:put => "/share_recording_with_emails/1").to route_to("share_recording_with_emails#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/share_recording_with_emails/1").to route_to("share_recording_with_emails#destroy", :id => "1")
    end

  end
end
