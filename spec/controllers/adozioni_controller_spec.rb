require 'spec_helper'

describe AdozioniController do

  def mock_adozione(stubs={})
    (@mock_adozione ||= mock_model(Adozione).as_null_object).tap do |adozione|
      adozione.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all adozioni as @adozioni" do
      Adozione.stub(:all) { [mock_adozione] }
      get :index
      assigns(:adozioni).should eq([mock_adozione])
    end
  end

  describe "GET show" do
    it "assigns the requested adozione as @adozione" do
      Adozione.stub(:find).with("37") { mock_adozione }
      get :show, :id => "37"
      assigns(:adozione).should be(mock_adozione)
    end
  end

  describe "GET new" do
    it "assigns a new adozione as @adozione" do
      Adozione.stub(:new) { mock_adozione }
      get :new
      assigns(:adozione).should be(mock_adozione)
    end
  end

  describe "GET edit" do
    it "assigns the requested adozione as @adozione" do
      Adozione.stub(:find).with("37") { mock_adozione }
      get :edit, :id => "37"
      assigns(:adozione).should be(mock_adozione)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created adozione as @adozione" do
        Adozione.stub(:new).with({'these' => 'params'}) { mock_adozione(:save => true) }
        post :create, :adozione => {'these' => 'params'}
        assigns(:adozione).should be(mock_adozione)
      end

      it "redirects to the created adozione" do
        Adozione.stub(:new) { mock_adozione(:save => true) }
        post :create, :adozione => {}
        response.should redirect_to(adozione_url(mock_adozione))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved adozione as @adozione" do
        Adozione.stub(:new).with({'these' => 'params'}) { mock_adozione(:save => false) }
        post :create, :adozione => {'these' => 'params'}
        assigns(:adozione).should be(mock_adozione)
      end

      it "re-renders the 'new' template" do
        Adozione.stub(:new) { mock_adozione(:save => false) }
        post :create, :adozione => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested adozione" do
        Adozione.should_receive(:find).with("37") { mock_adozione }
        mock_adozione.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :adozione => {'these' => 'params'}
      end

      it "assigns the requested adozione as @adozione" do
        Adozione.stub(:find) { mock_adozione(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:adozione).should be(mock_adozione)
      end

      it "redirects to the adozione" do
        Adozione.stub(:find) { mock_adozione(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(adozione_url(mock_adozione))
      end
    end

    describe "with invalid params" do
      it "assigns the adozione as @adozione" do
        Adozione.stub(:find) { mock_adozione(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:adozione).should be(mock_adozione)
      end

      it "re-renders the 'edit' template" do
        Adozione.stub(:find) { mock_adozione(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested adozione" do
      Adozione.should_receive(:find).with("37") { mock_adozione }
      mock_adozione.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the adozioni list" do
      Adozione.stub(:find) { mock_adozione }
      delete :destroy, :id => "1"
      response.should redirect_to(adozioni_url)
    end
  end

end
