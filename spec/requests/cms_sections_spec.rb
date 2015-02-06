require 'rails_helper'

RSpec.describe "CmsSections", :type => :request do
  describe "GET /cms_sections" do
    it "works! (now write some real specs)" do
      get cms_sections_path
      expect(response).to have_http_status(200)
    end
  end
end
