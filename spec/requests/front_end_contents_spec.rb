require 'rails_helper'

RSpec.describe "FrontEndContents", :type => :request do
  describe "GET /front_end_contents" do
    it "works! (now write some real specs)" do
      get front_end_contents_path
      expect(response).to have_http_status(200)
    end
  end
end
