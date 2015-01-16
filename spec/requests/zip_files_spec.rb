require 'rails_helper'

RSpec.describe "ZipFiles", :type => :request do
  describe "GET /zip_files" do
    it "works! (now write some real specs)" do
      get zip_files_path
      expect(response).to have_http_status(200)
    end
  end
end
