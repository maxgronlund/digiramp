require 'rails_helper'

RSpec.describe "CmsNavigationBars", :type => :request do
  describe "GET /cms_navigation_bars" do
    it "works! (now write some real specs)" do
      get cms_navigation_bars_path
      expect(response).to have_http_status(200)
    end
  end
end
