require "rails_helper"

RSpec.describe User::CmsContactsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/user/cms_contacts").to route_to("user/cms_contacts#index")
    end

    it "routes to #new" do
      expect(:get => "/user/cms_contacts/new").to route_to("user/cms_contacts#new")
    end

    it "routes to #show" do
      expect(:get => "/user/cms_contacts/1").to route_to("user/cms_contacts#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/user/cms_contacts/1/edit").to route_to("user/cms_contacts#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/user/cms_contacts").to route_to("user/cms_contacts#create")
    end

    it "routes to #update" do
      expect(:put => "/user/cms_contacts/1").to route_to("user/cms_contacts#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/user/cms_contacts/1").to route_to("user/cms_contacts#destroy", :id => "1")
    end

  end
end
