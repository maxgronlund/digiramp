require 'rails_helper'

RSpec.describe AddUsersToEmailGroupsController, :type => :controller do

  describe "GET all_members" do
    it "returns http success" do
      get :all_members
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET one_user" do
    it "returns http success" do
      get :one_user
      expect(response).to have_http_status(:success)
    end
  end

end
