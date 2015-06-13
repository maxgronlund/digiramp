require 'rails_helper'

RSpec.describe "MandrillTesters", type: :request do
  describe "GET /mandrill_testers" do
    it "works! (now write some real specs)" do
      get mandrill_testers_path
      expect(response).to have_http_status(200)
    end
  end
end
