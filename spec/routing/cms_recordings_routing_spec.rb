require "rails_helper"

RSpec.describe CmsRecordingsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/cms_recordings").to route_to("cms_recordings#index")
    end

    it "routes to #new" do
      expect(:get => "/cms_recordings/new").to route_to("cms_recordings#new")
    end

    it "routes to #show" do
      expect(:get => "/cms_recordings/1").to route_to("cms_recordings#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/cms_recordings/1/edit").to route_to("cms_recordings#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/cms_recordings").to route_to("cms_recordings#create")
    end

    it "routes to #update" do
      expect(:put => "/cms_recordings/1").to route_to("cms_recordings#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/cms_recordings/1").to route_to("cms_recordings#destroy", :id => "1")
    end

  end
end
