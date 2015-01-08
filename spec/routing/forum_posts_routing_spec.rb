require "rails_helper"

RSpec.describe ForumPostsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/forum_posts").to route_to("forum_posts#index")
    end

    it "routes to #new" do
      expect(:get => "/forum_posts/new").to route_to("forum_posts#new")
    end

    it "routes to #show" do
      expect(:get => "/forum_posts/1").to route_to("forum_posts#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/forum_posts/1/edit").to route_to("forum_posts#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/forum_posts").to route_to("forum_posts#create")
    end

    it "routes to #update" do
      expect(:put => "/forum_posts/1").to route_to("forum_posts#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/forum_posts/1").to route_to("forum_posts#destroy", :id => "1")
    end

  end
end
