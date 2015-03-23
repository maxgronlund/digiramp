require 'rails_helper'

RSpec.describe "CreativeProjectRoles", :type => :request do
  describe "GET /creative_project_roles" do
    it "works! (now write some real specs)" do
      get creative_project_roles_path
      expect(response).to have_http_status(200)
    end
  end
end
