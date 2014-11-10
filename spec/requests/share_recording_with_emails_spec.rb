require 'rails_helper'

RSpec.describe "ShareRecordingWithEmails", :type => :request do
  describe "GET /share_recording_with_emails" do
    it "works! (now write some real specs)" do
      get share_recording_with_emails_path
      expect(response).to have_http_status(200)
    end
  end
end
