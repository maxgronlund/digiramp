require "rails_helper"

RSpec.describe ShareOnTwittersController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/share_on_twitters").to route_to("share_on_twitters#index")
    end

    it "routes to #new" do
      expect(:get => "/share_on_twitters/new").to route_to("share_on_twitters#new")
    end

    it "routes to #show" do
      expect(:get => "/share_on_twitters/1").to route_to("share_on_twitters#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/share_on_twitters/1/edit").to route_to("share_on_twitters#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/share_on_twitters").to route_to("share_on_twitters#create")
    end

    it "routes to #update" do
      expect(:put => "/share_on_twitters/1").to route_to("share_on_twitters#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/share_on_twitters/1").to route_to("share_on_twitters#destroy", :id => "1")
    end

  end
end
