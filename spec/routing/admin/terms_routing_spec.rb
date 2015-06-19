require "rails_helper"

RSpec.describe Admin::TermsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/terms").to route_to("admin/terms#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/terms/new").to route_to("admin/terms#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/terms/1").to route_to("admin/terms#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/terms/1/edit").to route_to("admin/terms#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/terms").to route_to("admin/terms#create")
    end

    it "routes to #update" do
      expect(:put => "/admin/terms/1").to route_to("admin/terms#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/terms/1").to route_to("admin/terms#destroy", :id => "1")
    end

  end
end
