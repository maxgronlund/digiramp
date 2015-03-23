require "rails_helper"

RSpec.describe CreativeProjectResourcesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/creative_project_resources").to route_to("creative_project_resources#index")
    end

    it "routes to #new" do
      expect(:get => "/creative_project_resources/new").to route_to("creative_project_resources#new")
    end

    it "routes to #show" do
      expect(:get => "/creative_project_resources/1").to route_to("creative_project_resources#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/creative_project_resources/1/edit").to route_to("creative_project_resources#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/creative_project_resources").to route_to("creative_project_resources#create")
    end

    it "routes to #update" do
      expect(:put => "/creative_project_resources/1").to route_to("creative_project_resources#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/creative_project_resources/1").to route_to("creative_project_resources#destroy", :id => "1")
    end

  end
end
