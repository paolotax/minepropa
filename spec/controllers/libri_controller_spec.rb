require 'spec_helper'

describe LibriController do

  def mock_libro(stubs={})
    (@mock_libro ||= mock_model(Libro).as_null_object).tap do |libro|
      libro.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all libri as @libri" do
      Libro.stub(:all) { [mock_libro] }
      get :index
      assigns(:libri).should eq([mock_libro])
    end
  end

  describe "GET show" do
    it "assigns the requested libro as @libro" do
      Libro.stub(:find).with("37") { mock_libro }
      get :show, :id => "37"
      assigns(:libro).should be(mock_libro)
    end
  end

  describe "GET new" do
    it "assigns a new libro as @libro" do
      Libro.stub(:new) { mock_libro }
      get :new
      assigns(:libro).should be(mock_libro)
    end
  end

  describe "GET edit" do
    it "assigns the requested libro as @libro" do
      Libro.stub(:find).with("37") { mock_libro }
      get :edit, :id => "37"
      assigns(:libro).should be(mock_libro)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created libro as @libro" do
        Libro.stub(:new).with({'these' => 'params'}) { mock_libro(:save => true) }
        post :create, :libro => {'these' => 'params'}
        assigns(:libro).should be(mock_libro)
      end

      it "redirects to the created libro" do
        Libro.stub(:new) { mock_libro(:save => true) }
        post :create, :libro => {}
        response.should redirect_to(libro_url(mock_libro))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved libro as @libro" do
        Libro.stub(:new).with({'these' => 'params'}) { mock_libro(:save => false) }
        post :create, :libro => {'these' => 'params'}
        assigns(:libro).should be(mock_libro)
      end

      it "re-renders the 'new' template" do
        Libro.stub(:new) { mock_libro(:save => false) }
        post :create, :libro => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested libro" do
        Libro.should_receive(:find).with("37") { mock_libro }
        mock_libro.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :libro => {'these' => 'params'}
      end

      it "assigns the requested libro as @libro" do
        Libro.stub(:find) { mock_libro(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:libro).should be(mock_libro)
      end

      it "redirects to the libro" do
        Libro.stub(:find) { mock_libro(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(libro_url(mock_libro))
      end
    end

    describe "with invalid params" do
      it "assigns the libro as @libro" do
        Libro.stub(:find) { mock_libro(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:libro).should be(mock_libro)
      end

      it "re-renders the 'edit' template" do
        Libro.stub(:find) { mock_libro(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested libro" do
      Libro.should_receive(:find).with("37") { mock_libro }
      mock_libro.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the libri list" do
      Libro.stub(:find) { mock_libro }
      delete :destroy, :id => "1"
      response.should redirect_to(libri_url)
    end
  end

end
