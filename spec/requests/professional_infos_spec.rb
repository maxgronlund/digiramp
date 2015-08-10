require 'rails_helper'

RSpec.describe "ProfessionalInfos", type: :request do
  describe "GET /professional_infos" do
    it "works! (now write some real specs)" do
      get professional_infos_path
      expect(response).to have_http_status(200)
    end
  end
end
