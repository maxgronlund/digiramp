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

RSpec.describe BlacklistDomainsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # BlacklistDomain. As you add validations to BlacklistDomain, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # BlacklistDomainsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all blacklist_domains as @blacklist_domains" do
      blacklist_domain = BlacklistDomain.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:blacklist_domains)).to eq([blacklist_domain])
    end
  end

  describe "GET #show" do
    it "assigns the requested blacklist_domain as @blacklist_domain" do
      blacklist_domain = BlacklistDomain.create! valid_attributes
      get :show, {:id => blacklist_domain.to_param}, valid_session
      expect(assigns(:blacklist_domain)).to eq(blacklist_domain)
    end
  end

  describe "GET #new" do
    it "assigns a new blacklist_domain as @blacklist_domain" do
      get :new, {}, valid_session
      expect(assigns(:blacklist_domain)).to be_a_new(BlacklistDomain)
    end
  end

  describe "GET #edit" do
    it "assigns the requested blacklist_domain as @blacklist_domain" do
      blacklist_domain = BlacklistDomain.create! valid_attributes
      get :edit, {:id => blacklist_domain.to_param}, valid_session
      expect(assigns(:blacklist_domain)).to eq(blacklist_domain)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new BlacklistDomain" do
        expect {
          post :create, {:blacklist_domain => valid_attributes}, valid_session
        }.to change(BlacklistDomain, :count).by(1)
      end

      it "assigns a newly created blacklist_domain as @blacklist_domain" do
        post :create, {:blacklist_domain => valid_attributes}, valid_session
        expect(assigns(:blacklist_domain)).to be_a(BlacklistDomain)
        expect(assigns(:blacklist_domain)).to be_persisted
      end

      it "redirects to the created blacklist_domain" do
        post :create, {:blacklist_domain => valid_attributes}, valid_session
        expect(response).to redirect_to(BlacklistDomain.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved blacklist_domain as @blacklist_domain" do
        post :create, {:blacklist_domain => invalid_attributes}, valid_session
        expect(assigns(:blacklist_domain)).to be_a_new(BlacklistDomain)
      end

      it "re-renders the 'new' template" do
        post :create, {:blacklist_domain => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested blacklist_domain" do
        blacklist_domain = BlacklistDomain.create! valid_attributes
        put :update, {:id => blacklist_domain.to_param, :blacklist_domain => new_attributes}, valid_session
        blacklist_domain.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested blacklist_domain as @blacklist_domain" do
        blacklist_domain = BlacklistDomain.create! valid_attributes
        put :update, {:id => blacklist_domain.to_param, :blacklist_domain => valid_attributes}, valid_session
        expect(assigns(:blacklist_domain)).to eq(blacklist_domain)
      end

      it "redirects to the blacklist_domain" do
        blacklist_domain = BlacklistDomain.create! valid_attributes
        put :update, {:id => blacklist_domain.to_param, :blacklist_domain => valid_attributes}, valid_session
        expect(response).to redirect_to(blacklist_domain)
      end
    end

    context "with invalid params" do
      it "assigns the blacklist_domain as @blacklist_domain" do
        blacklist_domain = BlacklistDomain.create! valid_attributes
        put :update, {:id => blacklist_domain.to_param, :blacklist_domain => invalid_attributes}, valid_session
        expect(assigns(:blacklist_domain)).to eq(blacklist_domain)
      end

      it "re-renders the 'edit' template" do
        blacklist_domain = BlacklistDomain.create! valid_attributes
        put :update, {:id => blacklist_domain.to_param, :blacklist_domain => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested blacklist_domain" do
      blacklist_domain = BlacklistDomain.create! valid_attributes
      expect {
        delete :destroy, {:id => blacklist_domain.to_param}, valid_session
      }.to change(BlacklistDomain, :count).by(-1)
    end

    it "redirects to the blacklist_domains list" do
      blacklist_domain = BlacklistDomain.create! valid_attributes
      delete :destroy, {:id => blacklist_domain.to_param}, valid_session
      expect(response).to redirect_to(blacklist_domains_url)
    end
  end

end