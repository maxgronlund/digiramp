require "rails_helper"

RSpec.describe CreativeProjectsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/creative_projects").to route_to("creative_projects#index")
    end

    it "routes to #new" do
      expect(:get => "/creative_projects/new").to route_to("creative_projects#new")
    end

    it "routes to #show" do
      expect(:get => "/creative_projects/1").to route_to("creative_projects#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/creative_projects/1/edit").to route_to("creative_projects#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/creative_projects").to route_to("creative_projects#create")
    end

    it "routes to #update" do
      expect(:put => "/creative_projects/1").to route_to("creative_projects#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/creative_projects/1").to route_to("creative_projects#destroy", :id => "1")
    end

  end
end
