require "rails_helper"

RSpec.describe IssueEventsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/issue_events").to route_to("issue_events#index")
    end

    it "routes to #new" do
      expect(:get => "/issue_events/new").to route_to("issue_events#new")
    end

    it "routes to #show" do
      expect(:get => "/issue_events/1").to route_to("issue_events#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/issue_events/1/edit").to route_to("issue_events#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/issue_events").to route_to("issue_events#create")
    end

    it "routes to #update" do
      expect(:put => "/issue_events/1").to route_to("issue_events#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/issue_events/1").to route_to("issue_events#destroy", :id => "1")
    end

  end
end
