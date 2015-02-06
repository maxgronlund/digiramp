require "rails_helper"

RSpec.describe CmsTextsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/cms_texts").to route_to("cms_texts#index")
    end

    it "routes to #new" do
      expect(:get => "/cms_texts/new").to route_to("cms_texts#new")
    end

    it "routes to #show" do
      expect(:get => "/cms_texts/1").to route_to("cms_texts#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/cms_texts/1/edit").to route_to("cms_texts#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/cms_texts").to route_to("cms_texts#create")
    end

    it "routes to #update" do
      expect(:put => "/cms_texts/1").to route_to("cms_texts#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/cms_texts/1").to route_to("cms_texts#destroy", :id => "1")
    end

  end
end
