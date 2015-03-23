require 'rails_helper'

RSpec.describe "CreativeProjects", :type => :request do
  describe "GET /creative_projects" do
    it "works! (now write some real specs)" do
      get creative_projects_path
      expect(response).to have_http_status(200)
    end
  end
end
