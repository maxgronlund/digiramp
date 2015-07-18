require 'rails_helper'

RSpec.describe "RecordingUsers", type: :request do
  describe "GET /recording_users" do
    it "works! (now write some real specs)" do
      get recording_users_path
      expect(response).to have_http_status(200)
    end
  end
end
