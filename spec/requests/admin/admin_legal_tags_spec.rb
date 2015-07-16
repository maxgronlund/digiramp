require 'rails_helper'

RSpec.describe "Admin::LegalTags", type: :request do
  describe "GET /admin_legal_tags" do
    it "works! (now write some real specs)" do
      get admin_legal_tags_path
      expect(response).to have_http_status(200)
    end
  end
end
