require "rails_helper"

RSpec.describe CmsSectionsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/cms_sections").to route_to("cms_sections#index")
    end

    it "routes to #new" do
      expect(:get => "/cms_sections/new").to route_to("cms_sections#new")
    end

    it "routes to #show" do
      expect(:get => "/cms_sections/1").to route_to("cms_sections#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/cms_sections/1/edit").to route_to("cms_sections#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/cms_sections").to route_to("cms_sections#create")
    end

    it "routes to #update" do
      expect(:put => "/cms_sections/1").to route_to("cms_sections#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/cms_sections/1").to route_to("cms_sections#destroy", :id => "1")
    end

  end
end
