require 'rails_helper'

RSpec.describe "Admin::Terms", type: :request do
  describe "GET /admin_terms" do
    it "works! (now write some real specs)" do
      get admin_terms_path
      expect(response).to have_http_status(200)
    end
  end
end
