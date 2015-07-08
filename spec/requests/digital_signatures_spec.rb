require 'rails_helper'

RSpec.describe "DigitalSignatures", type: :request do
  describe "GET /digital_signatures" do
    it "works! (now write some real specs)" do
      get digital_signatures_path
      expect(response).to have_http_status(200)
    end
  end
end
