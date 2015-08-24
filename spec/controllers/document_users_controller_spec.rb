require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe DocumentUsersController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # DocumentUser. As you add validations to DocumentUser, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # DocumentUsersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all document_users as @document_users" do
      document_user = DocumentUser.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:document_users)).to eq([document_user])
    end
  end

  describe "GET #show" do
    it "assigns the requested document_user as @document_user" do
      document_user = DocumentUser.create! valid_attributes
      get :show, {:id => document_user.to_param}, valid_session
      expect(assigns(:document_user)).to eq(document_user)
    end
  end

  describe "GET #new" do
    it "assigns a new document_user as @document_user" do
      get :new, {}, valid_session
      expect(assigns(:document_user)).to be_a_new(DocumentUser)
    end
  end

  describe "GET #edit" do
    it "assigns the requested document_user as @document_user" do
      document_user = DocumentUser.create! valid_attributes
      get :edit, {:id => document_user.to_param}, valid_session
      expect(assigns(:document_user)).to eq(document_user)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new DocumentUser" do
        expect {
          post :create, {:document_user => valid_attributes}, valid_session
        }.to change(DocumentUser, :count).by(1)
      end

      it "assigns a newly created document_user as @document_user" do
        post :create, {:document_user => valid_attributes}, valid_session
        expect(assigns(:document_user)).to be_a(DocumentUser)
        expect(assigns(:document_user)).to be_persisted
      end

      it "redirects to the created document_user" do
        post :create, {:document_user => valid_attributes}, valid_session
        expect(response).to redirect_to(DocumentUser.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved document_user as @document_user" do
        post :create, {:document_user => invalid_attributes}, valid_session
        expect(assigns(:document_user)).to be_a_new(DocumentUser)
      end

      it "re-renders the 'new' template" do
        post :create, {:document_user => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested document_user" do
        document_user = DocumentUser.create! valid_attributes
        put :update, {:id => document_user.to_param, :document_user => new_attributes}, valid_session
        document_user.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested document_user as @document_user" do
        document_user = DocumentUser.create! valid_attributes
        put :update, {:id => document_user.to_param, :document_user => valid_attributes}, valid_session
        expect(assigns(:document_user)).to eq(document_user)
      end

      it "redirects to the document_user" do
        document_user = DocumentUser.create! valid_attributes
        put :update, {:id => document_user.to_param, :document_user => valid_attributes}, valid_session
        expect(response).to redirect_to(document_user)
      end
    end

    context "with invalid params" do
      it "assigns the document_user as @document_user" do
        document_user = DocumentUser.create! valid_attributes
        put :update, {:id => document_user.to_param, :document_user => invalid_attributes}, valid_session
        expect(assigns(:document_user)).to eq(document_user)
      end

      it "re-renders the 'edit' template" do
        document_user = DocumentUser.create! valid_attributes
        put :update, {:id => document_user.to_param, :document_user => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested document_user" do
      document_user = DocumentUser.create! valid_attributes
      expect {
        delete :destroy, {:id => document_user.to_param}, valid_session
      }.to change(DocumentUser, :count).by(-1)
    end

    it "redirects to the document_users list" do
      document_user = DocumentUser.create! valid_attributes
      delete :destroy, {:id => document_user.to_param}, valid_session
      expect(response).to redirect_to(document_users_url)
    end
  end

end
