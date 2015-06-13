require "rails_helper"

RSpec.describe Admin::MandrillAccountsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/mandrill_accounts").to route_to("admin/mandrill_accounts#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/mandrill_accounts/new").to route_to("admin/mandrill_accounts#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/mandrill_accounts/1").to route_to("admin/mandrill_accounts#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/mandrill_accounts/1/edit").to route_to("admin/mandrill_accounts#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/mandrill_accounts").to route_to("admin/mandrill_accounts#create")
    end

    it "routes to #update" do
      expect(:put => "/admin/mandrill_accounts/1").to route_to("admin/mandrill_accounts#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/mandrill_accounts/1").to route_to("admin/mandrill_accounts#destroy", :id => "1")
    end

  end
end
