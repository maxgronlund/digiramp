require "rails_helper"

RSpec.describe DigirampEmailsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/digiramp_emails").to route_to("digiramp_emails#index")
    end

    it "routes to #new" do
      expect(:get => "/digiramp_emails/new").to route_to("digiramp_emails#new")
    end

    it "routes to #show" do
      expect(:get => "/digiramp_emails/1").to route_to("digiramp_emails#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/digiramp_emails/1/edit").to route_to("digiramp_emails#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/digiramp_emails").to route_to("digiramp_emails#create")
    end

    it "routes to #update" do
      expect(:put => "/digiramp_emails/1").to route_to("digiramp_emails#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/digiramp_emails/1").to route_to("digiramp_emails#destroy", :id => "1")
    end

  end
end
