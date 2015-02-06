require "rails_helper"

RSpec.describe CmsCommentsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/cms_comments").to route_to("cms_comments#index")
    end

    it "routes to #new" do
      expect(:get => "/cms_comments/new").to route_to("cms_comments#new")
    end

    it "routes to #show" do
      expect(:get => "/cms_comments/1").to route_to("cms_comments#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/cms_comments/1/edit").to route_to("cms_comments#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/cms_comments").to route_to("cms_comments#create")
    end

    it "routes to #update" do
      expect(:put => "/cms_comments/1").to route_to("cms_comments#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/cms_comments/1").to route_to("cms_comments#destroy", :id => "1")
    end

  end
end
