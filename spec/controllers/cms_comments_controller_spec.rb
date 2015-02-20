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

RSpec.describe CmsCommentsController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # CmsComment. As you add validations to CmsComment, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CmsCommentsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all cms_comments as @cms_comments" do
      cms_comment = CmsComment.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:cms_comments)).to eq([cms_comment])
    end
  end

  describe "GET show" do
    it "assigns the requested cms_comment as @cms_comment" do
      cms_comment = CmsComment.create! valid_attributes
      get :show, {:id => cms_comment.to_param}, valid_session
      expect(assigns(:cms_comment)).to eq(cms_comment)
    end
  end

  describe "GET new" do
    it "assigns a new cms_comment as @cms_comment" do
      get :new, {}, valid_session
      expect(assigns(:cms_comment)).to be_a_new(CmsComment)
    end
  end

  describe "GET edit" do
    it "assigns the requested cms_comment as @cms_comment" do
      cms_comment = CmsComment.create! valid_attributes
      get :edit, {:id => cms_comment.to_param}, valid_session
      expect(assigns(:cms_comment)).to eq(cms_comment)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new CmsComment" do
        expect {
          post :create, {:cms_comment => valid_attributes}, valid_session
        }.to change(CmsComment, :count).by(1)
      end

      it "assigns a newly created cms_comment as @cms_comment" do
        post :create, {:cms_comment => valid_attributes}, valid_session
        expect(assigns(:cms_comment)).to be_a(CmsComment)
        expect(assigns(:cms_comment)).to be_persisted
      end

      it "redirects to the created cms_comment" do
        post :create, {:cms_comment => valid_attributes}, valid_session
        expect(response).to redirect_to(CmsComment.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved cms_comment as @cms_comment" do
        post :create, {:cms_comment => invalid_attributes}, valid_session
        expect(assigns(:cms_comment)).to be_a_new(CmsComment)
      end

      it "re-renders the 'new' template" do
        post :create, {:cms_comment => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested cms_comment" do
        cms_comment = CmsComment.create! valid_attributes
        put :update, {:id => cms_comment.to_param, :cms_comment => new_attributes}, valid_session
        cms_comment.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested cms_comment as @cms_comment" do
        cms_comment = CmsComment.create! valid_attributes
        put :update, {:id => cms_comment.to_param, :cms_comment => valid_attributes}, valid_session
        expect(assigns(:cms_comment)).to eq(cms_comment)
      end

      it "redirects to the cms_comment" do
        cms_comment = CmsComment.create! valid_attributes
        put :update, {:id => cms_comment.to_param, :cms_comment => valid_attributes}, valid_session
        expect(response).to redirect_to(cms_comment)
      end
    end

    describe "with invalid params" do
      it "assigns the cms_comment as @cms_comment" do
        cms_comment = CmsComment.create! valid_attributes
        put :update, {:id => cms_comment.to_param, :cms_comment => invalid_attributes}, valid_session
        expect(assigns(:cms_comment)).to eq(cms_comment)
      end

      it "re-renders the 'edit' template" do
        cms_comment = CmsComment.create! valid_attributes
        put :update, {:id => cms_comment.to_param, :cms_comment => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested cms_comment" do
      cms_comment = CmsComment.create! valid_attributes
      expect {
        delete :destroy, {:id => cms_comment.to_param}, valid_session
      }.to change(CmsComment, :count).by(-1)
    end

    it "redirects to the cms_comments list" do
      cms_comment = CmsComment.create! valid_attributes
      delete :destroy, {:id => cms_comment.to_param}, valid_session
      expect(response).to redirect_to(cms_comments_url)
    end
  end

end