require 'rails_helper'

RSpec.describe Admin::NudgeController, type: :controller do

  describe "GET #invite_friend" do
    it "returns http success" do
      get :invite_friend
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #share_recordings" do
    it "returns http success" do
      get :share_recordings
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #connect_to_users" do
    it "returns http success" do
      get :connect_to_users
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #write_comments" do
    it "returns http success" do
      get :write_comments
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #like_recordings" do
    it "returns http success" do
      get :like_recordings
      expect(response).to have_http_status(:success)
    end
  end

end
