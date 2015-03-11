require "rails_helper"

RSpec.describe CmsUserActivitiesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/cms_user_activities").to route_to("cms_user_activities#index")
    end

    it "routes to #new" do
      expect(:get => "/cms_user_activities/new").to route_to("cms_user_activities#new")
    end

    it "routes to #show" do
      expect(:get => "/cms_user_activities/1").to route_to("cms_user_activities#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/cms_user_activities/1/edit").to route_to("cms_user_activities#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/cms_user_activities").to route_to("cms_user_activities#create")
    end

    it "routes to #update" do
      expect(:put => "/cms_user_activities/1").to route_to("cms_user_activities#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/cms_user_activities/1").to route_to("cms_user_activities#destroy", :id => "1")
    end

  end
end
