require "spec_helper"

describe AdozioniController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/adozioni" }.should route_to(:controller => "adozioni", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/adozioni/new" }.should route_to(:controller => "adozioni", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/adozioni/1" }.should route_to(:controller => "adozioni", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/adozioni/1/edit" }.should route_to(:controller => "adozioni", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/adozioni" }.should route_to(:controller => "adozioni", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/adozioni/1" }.should route_to(:controller => "adozioni", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/adozioni/1" }.should route_to(:controller => "adozioni", :action => "destroy", :id => "1")
    end

  end
end
