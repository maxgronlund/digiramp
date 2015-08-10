require "rails_helper"

RSpec.describe ProfessionalInfosController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/professional_infos").to route_to("professional_infos#index")
    end

    it "routes to #new" do
      expect(:get => "/professional_infos/new").to route_to("professional_infos#new")
    end

    it "routes to #show" do
      expect(:get => "/professional_infos/1").to route_to("professional_infos#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/professional_infos/1/edit").to route_to("professional_infos#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/professional_infos").to route_to("professional_infos#create")
    end

    it "routes to #update" do
      expect(:put => "/professional_infos/1").to route_to("professional_infos#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/professional_infos/1").to route_to("professional_infos#destroy", :id => "1")
    end

  end
end
