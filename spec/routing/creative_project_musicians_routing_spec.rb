require "rails_helper"

RSpec.describe CreativeProjectRolesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/creative_project_roles").to route_to("creative_project_roles#index")
    end

    it "routes to #new" do
      expect(:get => "/creative_project_roles/new").to route_to("creative_project_roles#new")
    end

    it "routes to #show" do
      expect(:get => "/creative_project_roles/1").to route_to("creative_project_roles#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/creative_project_roles/1/edit").to route_to("creative_project_roles#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/creative_project_roles").to route_to("creative_project_roles#create")
    end

    it "routes to #update" do
      expect(:put => "/creative_project_roles/1").to route_to("creative_project_roles#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/creative_project_roles/1").to route_to("creative_project_roles#destroy", :id => "1")
    end

  end
end
