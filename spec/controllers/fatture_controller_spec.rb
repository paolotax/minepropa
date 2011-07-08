require 'spec_helper'

describe FattureController do

  def mock_fattura(stubs={})
    (@mock_fattura ||= mock_model(Fattura).as_null_object).tap do |fattura|
      fattura.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all fatture as @fatture" do
      Fattura.stub(:all) { [mock_fattura] }
      get :index
      assigns(:fatture).should eq([mock_fattura])
    end
  end

  describe "GET show" do
    it "assigns the requested fattura as @fattura" do
      Fattura.stub(:find).with("37") { mock_fattura }
      get :show, :id => "37"
      assigns(:fattura).should be(mock_fattura)
    end
  end

  describe "GET new" do
    it "assigns a new fattura as @fattura" do
      Fattura.stub(:new) { mock_fattura }
      get :new
      assigns(:fattura).should be(mock_fattura)
    end
  end

  describe "GET edit" do
    it "assigns the requested fattura as @fattura" do
      Fattura.stub(:find).with("37") { mock_fattura }
      get :edit, :id => "37"
      assigns(:fattura).should be(mock_fattura)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created fattura as @fattura" do
        Fattura.stub(:new).with({'these' => 'params'}) { mock_fattura(:save => true) }
        post :create, :fattura => {'these' => 'params'}
        assigns(:fattura).should be(mock_fattura)
      end

      it "redirects to the created fattura" do
        Fattura.stub(:new) { mock_fattura(:save => true) }
        post :create, :fattura => {}
        response.should redirect_to(fattura_url(mock_fattura))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved fattura as @fattura" do
        Fattura.stub(:new).with({'these' => 'params'}) { mock_fattura(:save => false) }
        post :create, :fattura => {'these' => 'params'}
        assigns(:fattura).should be(mock_fattura)
      end

      it "re-renders the 'new' template" do
        Fattura.stub(:new) { mock_fattura(:save => false) }
        post :create, :fattura => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested fattura" do
        Fattura.should_receive(:find).with("37") { mock_fattura }
        mock_fattura.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :fattura => {'these' => 'params'}
      end

      it "assigns the requested fattura as @fattura" do
        Fattura.stub(:find) { mock_fattura(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:fattura).should be(mock_fattura)
      end

      it "redirects to the fattura" do
        Fattura.stub(:find) { mock_fattura(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(fattura_url(mock_fattura))
      end
    end

    describe "with invalid params" do
      it "assigns the fattura as @fattura" do
        Fattura.stub(:find) { mock_fattura(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:fattura).should be(mock_fattura)
      end

      it "re-renders the 'edit' template" do
        Fattura.stub(:find) { mock_fattura(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested fattura" do
      Fattura.should_receive(:find).with("37") { mock_fattura }
      mock_fattura.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the fatture list" do
      Fattura.stub(:find) { mock_fattura }
      delete :destroy, :id => "1"
      response.should redirect_to(fatture_url)
    end
  end

end
