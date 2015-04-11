require "rails_helper"

RSpec.describe ProUserSubscribtionsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/pro_user_subscribtions").to route_to("pro_user_subscribtions#index")
    end

    it "routes to #new" do
      expect(:get => "/pro_user_subscribtions/new").to route_to("pro_user_subscribtions#new")
    end

    it "routes to #show" do
      expect(:get => "/pro_user_subscribtions/1").to route_to("pro_user_subscribtions#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/pro_user_subscribtions/1/edit").to route_to("pro_user_subscribtions#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/pro_user_subscribtions").to route_to("pro_user_subscribtions#create")
    end

    it "routes to #update" do
      expect(:put => "/pro_user_subscribtions/1").to route_to("pro_user_subscribtions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/pro_user_subscribtions/1").to route_to("pro_user_subscribtions#destroy", :id => "1")
    end

  end
end
