require 'rails_helper'

RSpec.describe "UserConfigurations", type: :request do
  describe "GET /user_configurations" do
    it "works! (now write some real specs)" do
      get user_configurations_path
      expect(response).to have_http_status(200)
    end
  end
end
