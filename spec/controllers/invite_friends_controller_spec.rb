require 'rails_helper'

RSpec.describe InviteFriendsController, :type => :controller do

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET creat" do
    it "returns http success" do
      get :creat
      expect(response).to have_http_status(:success)
    end
  end

end
