require "rails_helper"

RSpec.describe DocumentUsersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/document_users").to route_to("document_users#index")
    end

    it "routes to #new" do
      expect(:get => "/document_users/new").to route_to("document_users#new")
    end

    it "routes to #show" do
      expect(:get => "/document_users/1").to route_to("document_users#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/document_users/1/edit").to route_to("document_users#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/document_users").to route_to("document_users#create")
    end

    it "routes to #update" do
      expect(:put => "/document_users/1").to route_to("document_users#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/document_users/1").to route_to("document_users#destroy", :id => "1")
    end

  end
end
