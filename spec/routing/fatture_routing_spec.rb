require "spec_helper"

describe FattureController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/fatture" }.should route_to(:controller => "fatture", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/fatture/new" }.should route_to(:controller => "fatture", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/fatture/1" }.should route_to(:controller => "fatture", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/fatture/1/edit" }.should route_to(:controller => "fatture", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/fatture" }.should route_to(:controller => "fatture", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/fatture/1" }.should route_to(:controller => "fatture", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/fatture/1" }.should route_to(:controller => "fatture", :action => "destroy", :id => "1")
    end

  end
end
