require "spec_helper"

describe MaterieController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/materie" }.should route_to(:controller => "materie", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/materie/new" }.should route_to(:controller => "materie", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/materie/1" }.should route_to(:controller => "materie", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/materie/1/edit" }.should route_to(:controller => "materie", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/materie" }.should route_to(:controller => "materie", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/materie/1" }.should route_to(:controller => "materie", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/materie/1" }.should route_to(:controller => "materie", :action => "destroy", :id => "1")
    end

  end
end
