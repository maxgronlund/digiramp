require "rails_helper"

RSpec.describe EmailGroupsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/email_groups").to route_to("email_groups#index")
    end

    it "routes to #new" do
      expect(:get => "/email_groups/new").to route_to("email_groups#new")
    end

    it "routes to #show" do
      expect(:get => "/email_groups/1").to route_to("email_groups#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/email_groups/1/edit").to route_to("email_groups#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/email_groups").to route_to("email_groups#create")
    end

    it "routes to #update" do
      expect(:put => "/email_groups/1").to route_to("email_groups#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/email_groups/1").to route_to("email_groups#destroy", :id => "1")
    end

  end
end
