require 'rails_helper'

RSpec.describe "UserEmails", :type => :request do
  describe "GET /user_emails" do
    it "works! (now write some real specs)" do
      get user_emails_path
      expect(response).to have_http_status(200)
    end
  end
end
