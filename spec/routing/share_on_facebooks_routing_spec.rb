require "rails_helper"

RSpec.describe ShareOnFacebooksController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/share_on_facebooks").to route_to("share_on_facebooks#index")
    end

    it "routes to #new" do
      expect(:get => "/share_on_facebooks/new").to route_to("share_on_facebooks#new")
    end

    it "routes to #show" do
      expect(:get => "/share_on_facebooks/1").to route_to("share_on_facebooks#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/share_on_facebooks/1/edit").to route_to("share_on_facebooks#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/share_on_facebooks").to route_to("share_on_facebooks#create")
    end

    it "routes to #update" do
      expect(:put => "/share_on_facebooks/1").to route_to("share_on_facebooks#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/share_on_facebooks/1").to route_to("share_on_facebooks#destroy", :id => "1")
    end

  end
end
