require "rails_helper"

RSpec.describe ZipFilesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/zip_files").to route_to("zip_files#index")
    end

    it "routes to #new" do
      expect(:get => "/zip_files/new").to route_to("zip_files#new")
    end

    it "routes to #show" do
      expect(:get => "/zip_files/1").to route_to("zip_files#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/zip_files/1/edit").to route_to("zip_files#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/zip_files").to route_to("zip_files#create")
    end

    it "routes to #update" do
      expect(:put => "/zip_files/1").to route_to("zip_files#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/zip_files/1").to route_to("zip_files#destroy", :id => "1")
    end

  end
end
