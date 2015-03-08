require 'rails_helper'

RSpec.describe "IssueEvents", :type => :request do
  describe "GET /issue_events" do
    it "works! (now write some real specs)" do
      get issue_events_path
      expect(response).to have_http_status(200)
    end
  end
end
