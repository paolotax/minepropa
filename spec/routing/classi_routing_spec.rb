require "spec_helper"

describe ClassiController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/classi" }.should route_to(:controller => "classi", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/classi/new" }.should route_to(:controller => "classi", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/classi/1" }.should route_to(:controller => "classi", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/classi/1/edit" }.should route_to(:controller => "classi", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/classi" }.should route_to(:controller => "classi", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/classi/1" }.should route_to(:controller => "classi", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/classi/1" }.should route_to(:controller => "classi", :action => "destroy", :id => "1")
    end

  end
end
