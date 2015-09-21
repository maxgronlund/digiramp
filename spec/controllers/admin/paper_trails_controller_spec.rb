require 'rails_helper'

RSpec.describe Admin::PaperTrailsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #orders" do
    it "returns http success" do
      get :orders
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #stakes" do
    it "returns http success" do
      get :stakes
      expect(response).to have_http_status(:success)
    end
  end

end
