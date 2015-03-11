require "rails_helper"

RSpec.describe PageStylesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/page_styles").to route_to("page_styles#index")
    end

    it "routes to #new" do
      expect(:get => "/page_styles/new").to route_to("page_styles#new")
    end

    it "routes to #show" do
      expect(:get => "/page_styles/1").to route_to("page_styles#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/page_styles/1/edit").to route_to("page_styles#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/page_styles").to route_to("page_styles#create")
    end

    it "routes to #update" do
      expect(:put => "/page_styles/1").to route_to("page_styles#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/page_styles/1").to route_to("page_styles#destroy", :id => "1")
    end

  end
end
