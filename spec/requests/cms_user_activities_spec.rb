require 'rails_helper'

RSpec.describe "CmsUserActivities", :type => :request do
  describe "GET /cms_user_activities" do
    it "works! (now write some real specs)" do
      get cms_user_activities_path
      expect(response).to have_http_status(200)
    end
  end
end
