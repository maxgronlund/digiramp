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

RSpec.describe CmsVerticalLinksController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # CmsVerticalLink. As you add validations to CmsVerticalLink, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CmsVerticalLinksController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all cms_vertical_links as @cms_vertical_links" do
      cms_vertical_link = CmsVerticalLink.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:cms_vertical_links)).to eq([cms_vertical_link])
    end
  end

  describe "GET show" do
    it "assigns the requested cms_vertical_link as @cms_vertical_link" do
      cms_vertical_link = CmsVerticalLink.create! valid_attributes
      get :show, {:id => cms_vertical_link.to_param}, valid_session
      expect(assigns(:cms_vertical_link)).to eq(cms_vertical_link)
    end
  end

  describe "GET new" do
    it "assigns a new cms_vertical_link as @cms_vertical_link" do
      get :new, {}, valid_session
      expect(assigns(:cms_vertical_link)).to be_a_new(CmsVerticalLink)
    end
  end

  describe "GET edit" do
    it "assigns the requested cms_vertical_link as @cms_vertical_link" do
      cms_vertical_link = CmsVerticalLink.create! valid_attributes
      get :edit, {:id => cms_vertical_link.to_param}, valid_session
      expect(assigns(:cms_vertical_link)).to eq(cms_vertical_link)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new CmsVerticalLink" do
        expect {
          post :create, {:cms_vertical_link => valid_attributes}, valid_session
        }.to change(CmsVerticalLink, :count).by(1)
      end

      it "assigns a newly created cms_vertical_link as @cms_vertical_link" do
        post :create, {:cms_vertical_link => valid_attributes}, valid_session
        expect(assigns(:cms_vertical_link)).to be_a(CmsVerticalLink)
        expect(assigns(:cms_vertical_link)).to be_persisted
      end

      it "redirects to the created cms_vertical_link" do
        post :create, {:cms_vertical_link => valid_attributes}, valid_session
        expect(response).to redirect_to(CmsVerticalLink.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved cms_vertical_link as @cms_vertical_link" do
        post :create, {:cms_vertical_link => invalid_attributes}, valid_session
        expect(assigns(:cms_vertical_link)).to be_a_new(CmsVerticalLink)
      end

      it "re-renders the 'new' template" do
        post :create, {:cms_vertical_link => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested cms_vertical_link" do
        cms_vertical_link = CmsVerticalLink.create! valid_attributes
        put :update, {:id => cms_vertical_link.to_param, :cms_vertical_link => new_attributes}, valid_session
        cms_vertical_link.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested cms_vertical_link as @cms_vertical_link" do
        cms_vertical_link = CmsVerticalLink.create! valid_attributes
        put :update, {:id => cms_vertical_link.to_param, :cms_vertical_link => valid_attributes}, valid_session
        expect(assigns(:cms_vertical_link)).to eq(cms_vertical_link)
      end

      it "redirects to the cms_vertical_link" do
        cms_vertical_link = CmsVerticalLink.create! valid_attributes
        put :update, {:id => cms_vertical_link.to_param, :cms_vertical_link => valid_attributes}, valid_session
        expect(response).to redirect_to(cms_vertical_link)
      end
    end

    describe "with invalid params" do
      it "assigns the cms_vertical_link as @cms_vertical_link" do
        cms_vertical_link = CmsVerticalLink.create! valid_attributes
        put :update, {:id => cms_vertical_link.to_param, :cms_vertical_link => invalid_attributes}, valid_session
        expect(assigns(:cms_vertical_link)).to eq(cms_vertical_link)
      end

      it "re-renders the 'edit' template" do
        cms_vertical_link = CmsVerticalLink.create! valid_attributes
        put :update, {:id => cms_vertical_link.to_param, :cms_vertical_link => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested cms_vertical_link" do
      cms_vertical_link = CmsVerticalLink.create! valid_attributes
      expect {
        delete :destroy, {:id => cms_vertical_link.to_param}, valid_session
      }.to change(CmsVerticalLink, :count).by(-1)
    end

    it "redirects to the cms_vertical_links list" do
      cms_vertical_link = CmsVerticalLink.create! valid_attributes
      delete :destroy, {:id => cms_vertical_link.to_param}, valid_session
      expect(response).to redirect_to(cms_vertical_links_url)
    end
  end

end