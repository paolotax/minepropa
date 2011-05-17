require 'spec_helper'

describe AppuntoRigheController do

  def mock_appunto_riga(stubs={})
    (@mock_appunto_riga ||= mock_model(AppuntoRiga).as_null_object).tap do |appunto_riga|
      appunto_riga.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all appunto_righe as @appunto_righe" do
      AppuntoRiga.stub(:all) { [mock_appunto_riga] }
      get :index
      assigns(:appunto_righe).should eq([mock_appunto_riga])
    end
  end

  describe "GET show" do
    it "assigns the requested appunto_riga as @appunto_riga" do
      AppuntoRiga.stub(:find).with("37") { mock_appunto_riga }
      get :show, :id => "37"
      assigns(:appunto_riga).should be(mock_appunto_riga)
    end
  end

  describe "GET new" do
    it "assigns a new appunto_riga as @appunto_riga" do
      AppuntoRiga.stub(:new) { mock_appunto_riga }
      get :new
      assigns(:appunto_riga).should be(mock_appunto_riga)
    end
  end

  describe "GET edit" do
    it "assigns the requested appunto_riga as @appunto_riga" do
      AppuntoRiga.stub(:find).with("37") { mock_appunto_riga }
      get :edit, :id => "37"
      assigns(:appunto_riga).should be(mock_appunto_riga)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created appunto_riga as @appunto_riga" do
        AppuntoRiga.stub(:new).with({'these' => 'params'}) { mock_appunto_riga(:save => true) }
        post :create, :appunto_riga => {'these' => 'params'}
        assigns(:appunto_riga).should be(mock_appunto_riga)
      end

      it "redirects to the created appunto_riga" do
        AppuntoRiga.stub(:new) { mock_appunto_riga(:save => true) }
        post :create, :appunto_riga => {}
        response.should redirect_to(appunto_riga_url(mock_appunto_riga))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved appunto_riga as @appunto_riga" do
        AppuntoRiga.stub(:new).with({'these' => 'params'}) { mock_appunto_riga(:save => false) }
        post :create, :appunto_riga => {'these' => 'params'}
        assigns(:appunto_riga).should be(mock_appunto_riga)
      end

      it "re-renders the 'new' template" do
        AppuntoRiga.stub(:new) { mock_appunto_riga(:save => false) }
        post :create, :appunto_riga => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested appunto_riga" do
        AppuntoRiga.should_receive(:find).with("37") { mock_appunto_riga }
        mock_appunto_riga.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :appunto_riga => {'these' => 'params'}
      end

      it "assigns the requested appunto_riga as @appunto_riga" do
        AppuntoRiga.stub(:find) { mock_appunto_riga(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:appunto_riga).should be(mock_appunto_riga)
      end

      it "redirects to the appunto_riga" do
        AppuntoRiga.stub(:find) { mock_appunto_riga(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(appunto_riga_url(mock_appunto_riga))
      end
    end

    describe "with invalid params" do
      it "assigns the appunto_riga as @appunto_riga" do
        AppuntoRiga.stub(:find) { mock_appunto_riga(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:appunto_riga).should be(mock_appunto_riga)
      end

      it "re-renders the 'edit' template" do
        AppuntoRiga.stub(:find) { mock_appunto_riga(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested appunto_riga" do
      AppuntoRiga.should_receive(:find).with("37") { mock_appunto_riga }
      mock_appunto_riga.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the appunto_righe list" do
      AppuntoRiga.stub(:find) { mock_appunto_riga }
      delete :destroy, :id => "1"
      response.should redirect_to(appunto_righe_url)
    end
  end

end
