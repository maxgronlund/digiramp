require "rails_helper"

RSpec.describe CreativeProjectUsersController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/creative_project_users").to route_to("creative_project_users#index")
    end

    it "routes to #new" do
      expect(:get => "/creative_project_users/new").to route_to("creative_project_users#new")
    end

    it "routes to #show" do
      expect(:get => "/creative_project_users/1").to route_to("creative_project_users#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/creative_project_users/1/edit").to route_to("creative_project_users#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/creative_project_users").to route_to("creative_project_users#create")
    end

    it "routes to #update" do
      expect(:put => "/creative_project_users/1").to route_to("creative_project_users#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/creative_project_users/1").to route_to("creative_project_users#destroy", :id => "1")
    end

  end
end
