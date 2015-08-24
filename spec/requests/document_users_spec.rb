require 'rails_helper'

RSpec.describe "DocumentUsers", type: :request do
  describe "GET /document_users" do
    it "works! (now write some real specs)" do
      get document_users_path
      expect(response).to have_http_status(200)
    end
  end
end
