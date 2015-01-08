require 'rails_helper'

RSpec.describe "ForumPosts", :type => :request do
  describe "GET /forum_posts" do
    it "works! (now write some real specs)" do
      get forum_posts_path
      expect(response).to have_http_status(200)
    end
  end
end
