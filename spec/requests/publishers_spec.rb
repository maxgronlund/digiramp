require 'rails_helper'

RSpec.describe "Publishers", type: :request do
  describe "GET /publishers" do
    it "works! (now write some real specs)" do
      get publishers_path
      expect(response).to have_http_status(200)
    end
  end
end
