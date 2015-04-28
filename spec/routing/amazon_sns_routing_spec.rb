require "rails_helper"

RSpec.describe AmazonSnsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/amazon_sns").to route_to("amazon_sns#index")
    end

    it "routes to #new" do
      expect(:get => "/amazon_sns/new").to route_to("amazon_sns#new")
    end

    it "routes to #show" do
      expect(:get => "/amazon_sns/1").to route_to("amazon_sns#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/amazon_sns/1/edit").to route_to("amazon_sns#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/amazon_sns").to route_to("amazon_sns#create")
    end

    it "routes to #update" do
      expect(:put => "/amazon_sns/1").to route_to("amazon_sns#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/amazon_sns/1").to route_to("amazon_sns#destroy", :id => "1")
    end

  end
end
