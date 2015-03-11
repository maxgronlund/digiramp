require 'rails_helper'

RSpec.describe "PageStyles", :type => :request do
  describe "GET /page_styles" do
    it "works! (now write some real specs)" do
      get page_styles_path
      expect(response).to have_http_status(200)
    end
  end
end
