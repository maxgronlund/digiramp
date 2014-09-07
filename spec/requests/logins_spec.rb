require 'rails_helper'

RSpec.describe "Logins", :type => :request do
  describe "GET /logins" do
    it "works! (now write some real specs)" do
      FactoryGirl.create(:admin)
      get login_new_path
      
      
      expect(response).to render_template("new")
            
            
      #expect(response).to have_http_status(200)
    end
  end
end
