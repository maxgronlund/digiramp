require "rails_helper"

RSpec.describe Admin::LegalTagsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/legal_tags").to route_to("admin/legal_tags#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/legal_tags/new").to route_to("admin/legal_tags#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/legal_tags/1").to route_to("admin/legal_tags#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/legal_tags/1/edit").to route_to("admin/legal_tags#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/legal_tags").to route_to("admin/legal_tags#create")
    end

    it "routes to #update" do
      expect(:put => "/admin/legal_tags/1").to route_to("admin/legal_tags#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/legal_tags/1").to route_to("admin/legal_tags#destroy", :id => "1")
    end

  end
end
