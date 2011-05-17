require "spec_helper"

describe AppuntoRigheController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/appunto_righe" }.should route_to(:controller => "appunto_righe", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/appunto_righe/new" }.should route_to(:controller => "appunto_righe", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/appunto_righe/1" }.should route_to(:controller => "appunto_righe", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/appunto_righe/1/edit" }.should route_to(:controller => "appunto_righe", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/appunto_righe" }.should route_to(:controller => "appunto_righe", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/appunto_righe/1" }.should route_to(:controller => "appunto_righe", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/appunto_righe/1" }.should route_to(:controller => "appunto_righe", :action => "destroy", :id => "1")
    end

  end
end
