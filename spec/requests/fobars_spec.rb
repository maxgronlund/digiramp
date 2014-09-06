require 'rails_helper'

RSpec.describe "Fobars", :type => :request do
  describe "GET /fobars" do
    it "works! (now write some real specs)" do
      get fobars_path
      expect(response).to have_http_status(200)
    end
  end
end
