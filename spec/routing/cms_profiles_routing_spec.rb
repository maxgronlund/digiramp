require "rails_helper"

RSpec.describe CmsProfilesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/cms_profiles").to route_to("cms_profiles#index")
    end

    it "routes to #new" do
      expect(:get => "/cms_profiles/new").to route_to("cms_profiles#new")
    end

    it "routes to #show" do
      expect(:get => "/cms_profiles/1").to route_to("cms_profiles#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/cms_profiles/1/edit").to route_to("cms_profiles#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/cms_profiles").to route_to("cms_profiles#create")
    end

    it "routes to #update" do
      expect(:put => "/cms_profiles/1").to route_to("cms_profiles#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/cms_profiles/1").to route_to("cms_profiles#destroy", :id => "1")
    end

  end
end
