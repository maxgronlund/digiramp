require "rails_helper"

RSpec.describe CmsNavigationBarsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/cms_navigation_bars").to route_to("cms_navigation_bars#index")
    end

    it "routes to #new" do
      expect(:get => "/cms_navigation_bars/new").to route_to("cms_navigation_bars#new")
    end

    it "routes to #show" do
      expect(:get => "/cms_navigation_bars/1").to route_to("cms_navigation_bars#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/cms_navigation_bars/1/edit").to route_to("cms_navigation_bars#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/cms_navigation_bars").to route_to("cms_navigation_bars#create")
    end

    it "routes to #update" do
      expect(:put => "/cms_navigation_bars/1").to route_to("cms_navigation_bars#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/cms_navigation_bars/1").to route_to("cms_navigation_bars#destroy", :id => "1")
    end

  end
end
