require "spec_helper"

describe LibriController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/libri" }.should route_to(:controller => "libri", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/libri/new" }.should route_to(:controller => "libri", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/libri/1" }.should route_to(:controller => "libri", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/libri/1/edit" }.should route_to(:controller => "libri", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/libri" }.should route_to(:controller => "libri", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/libri/1" }.should route_to(:controller => "libri", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/libri/1" }.should route_to(:controller => "libri", :action => "destroy", :id => "1")
    end

  end
end
