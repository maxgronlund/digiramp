require 'rails_helper'

RSpec.describe "Instructions", :type => :request do
  describe "GET /instructions" do
    it "works! (now write some real specs)" do
      get instructions_path
      expect(response).to have_http_status(200)
    end
  end
end
