require 'rails_helper'

RSpec.describe "User::CmsContacts", :type => :request do
  describe "GET /user_cms_contacts" do
    it "works! (now write some real specs)" do
      get user_cms_contacts_path
      expect(response).to have_http_status(200)
    end
  end
end
