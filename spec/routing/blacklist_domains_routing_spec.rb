require "rails_helper"

RSpec.describe BlacklistDomainsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/blacklist_domains").to route_to("blacklist_domains#index")
    end

    it "routes to #new" do
      expect(:get => "/blacklist_domains/new").to route_to("blacklist_domains#new")
    end

    it "routes to #show" do
      expect(:get => "/blacklist_domains/1").to route_to("blacklist_domains#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/blacklist_domains/1/edit").to route_to("blacklist_domains#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/blacklist_domains").to route_to("blacklist_domains#create")
    end

    it "routes to #update" do
      expect(:put => "/blacklist_domains/1").to route_to("blacklist_domains#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/blacklist_domains/1").to route_to("blacklist_domains#destroy", :id => "1")
    end

  end
end
