require "rails_helper"

RSpec.describe DigitalSignaturesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/digital_signatures").to route_to("digital_signatures#index")
    end

    it "routes to #new" do
      expect(:get => "/digital_signatures/new").to route_to("digital_signatures#new")
    end

    it "routes to #show" do
      expect(:get => "/digital_signatures/1").to route_to("digital_signatures#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/digital_signatures/1/edit").to route_to("digital_signatures#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/digital_signatures").to route_to("digital_signatures#create")
    end

    it "routes to #update" do
      expect(:put => "/digital_signatures/1").to route_to("digital_signatures#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/digital_signatures/1").to route_to("digital_signatures#destroy", :id => "1")
    end

  end
end
