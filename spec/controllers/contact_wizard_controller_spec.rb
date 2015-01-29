require 'rails_helper'

RSpec.describe ContactWizardController, :type => :controller do

  describe "GET fill_form" do
    it "returns http success" do
      get :fill_form
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET submit_form" do
    it "returns http success" do
      get :submit_form
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET upload_file" do
    it "returns http success" do
      get :upload_file
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET upload_custom_csv" do
    it "returns http success" do
      get :upload_custom_csv
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET submit_custom_csv" do
    it "returns http success" do
      get :submit_custom_csv
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET upload_linkedin_csv" do
    it "returns http success" do
      get :upload_linkedin_csv
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET submit_linkedin_csv" do
    it "returns http success" do
      get :submit_linkedin_csv
      expect(response).to have_http_status(:success)
    end
  end

end
