require 'spec_helper'

describe MaterieController do

  def mock_materia(stubs={})
    (@mock_materia ||= mock_model(Materia).as_null_object).tap do |materia|
      materia.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all materie as @materie" do
      Materia.stub(:all) { [mock_materia] }
      get :index
      assigns(:materie).should eq([mock_materia])
    end
  end

  describe "GET show" do
    it "assigns the requested materia as @materia" do
      Materia.stub(:find).with("37") { mock_materia }
      get :show, :id => "37"
      assigns(:materia).should be(mock_materia)
    end
  end

  describe "GET new" do
    it "assigns a new materia as @materia" do
      Materia.stub(:new) { mock_materia }
      get :new
      assigns(:materia).should be(mock_materia)
    end
  end

  describe "GET edit" do
    it "assigns the requested materia as @materia" do
      Materia.stub(:find).with("37") { mock_materia }
      get :edit, :id => "37"
      assigns(:materia).should be(mock_materia)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created materia as @materia" do
        Materia.stub(:new).with({'these' => 'params'}) { mock_materia(:save => true) }
        post :create, :materia => {'these' => 'params'}
        assigns(:materia).should be(mock_materia)
      end

      it "redirects to the created materia" do
        Materia.stub(:new) { mock_materia(:save => true) }
        post :create, :materia => {}
        response.should redirect_to(materia_url(mock_materia))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved materia as @materia" do
        Materia.stub(:new).with({'these' => 'params'}) { mock_materia(:save => false) }
        post :create, :materia => {'these' => 'params'}
        assigns(:materia).should be(mock_materia)
      end

      it "re-renders the 'new' template" do
        Materia.stub(:new) { mock_materia(:save => false) }
        post :create, :materia => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested materia" do
        Materia.should_receive(:find).with("37") { mock_materia }
        mock_materia.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :materia => {'these' => 'params'}
      end

      it "assigns the requested materia as @materia" do
        Materia.stub(:find) { mock_materia(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:materia).should be(mock_materia)
      end

      it "redirects to the materia" do
        Materia.stub(:find) { mock_materia(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(materia_url(mock_materia))
      end
    end

    describe "with invalid params" do
      it "assigns the materia as @materia" do
        Materia.stub(:find) { mock_materia(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:materia).should be(mock_materia)
      end

      it "re-renders the 'edit' template" do
        Materia.stub(:find) { mock_materia(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested materia" do
      Materia.should_receive(:find).with("37") { mock_materia }
      mock_materia.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the materie list" do
      Materia.stub(:find) { mock_materia }
      delete :destroy, :id => "1"
      response.should redirect_to(materie_url)
    end
  end

end
