require "rails_helper"

RSpec.describe CmsPagesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/cms_pages").to route_to("cms_pages#index")
    end

    it "routes to #new" do
      expect(:get => "/cms_pages/new").to route_to("cms_pages#new")
    end

    it "routes to #show" do
      expect(:get => "/cms_pages/1").to route_to("cms_pages#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/cms_pages/1/edit").to route_to("cms_pages#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/cms_pages").to route_to("cms_pages#create")
    end

    it "routes to #update" do
      expect(:put => "/cms_pages/1").to route_to("cms_pages#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/cms_pages/1").to route_to("cms_pages#destroy", :id => "1")
    end

  end
end
