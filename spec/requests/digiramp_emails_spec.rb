require 'rails_helper'

RSpec.describe "DigirampEmails", :type => :request do
  describe "GET /digiramp_emails" do
    it "works! (now write some real specs)" do
      get digiramp_emails_path
      expect(response).to have_http_status(200)
    end
  end
end
