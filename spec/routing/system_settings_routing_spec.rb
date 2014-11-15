require "rails_helper"

RSpec.describe SystemSettingsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/system_settings").to route_to("system_settings#index")
    end

    it "routes to #new" do
      expect(:get => "/system_settings/new").to route_to("system_settings#new")
    end

    it "routes to #show" do
      expect(:get => "/system_settings/1").to route_to("system_settings#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/system_settings/1/edit").to route_to("system_settings#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/system_settings").to route_to("system_settings#create")
    end

    it "routes to #update" do
      expect(:put => "/system_settings/1").to route_to("system_settings#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/system_settings/1").to route_to("system_settings#destroy", :id => "1")
    end

  end
end
