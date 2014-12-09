require 'rails_helper'

RSpec.describe "Connections", :type => :request do
  describe "GET /connections" do
    it "works! (now write some real specs)" do
      get connections_path
      expect(response).to have_http_status(200)
    end
  end
end
