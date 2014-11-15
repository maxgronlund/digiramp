require 'rails_helper'

RSpec.describe "SystemSettings", :type => :request do
  describe "GET /system_settings" do
    it "works! (now write some real specs)" do
      get system_settings_path
      expect(response).to have_http_status(200)
    end
  end
end
