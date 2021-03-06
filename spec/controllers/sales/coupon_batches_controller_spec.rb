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

RSpec.describe Sales::CouponBatchesController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # Sales::CouponBatch. As you add validations to Sales::CouponBatch, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # Sales::CouponBatchesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all sales_coupon_batches as @sales_coupon_batches" do
      coupon_batch = Sales::CouponBatch.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:sales_coupon_batches)).to eq([coupon_batch])
    end
  end

  describe "GET show" do
    it "assigns the requested sales_coupon_batch as @sales_coupon_batch" do
      coupon_batch = Sales::CouponBatch.create! valid_attributes
      get :show, {:id => coupon_batch.to_param}, valid_session
      expect(assigns(:sales_coupon_batch)).to eq(coupon_batch)
    end
  end

  describe "GET new" do
    it "assigns a new sales_coupon_batch as @sales_coupon_batch" do
      get :new, {}, valid_session
      expect(assigns(:sales_coupon_batch)).to be_a_new(Sales::CouponBatch)
    end
  end

  describe "GET edit" do
    it "assigns the requested sales_coupon_batch as @sales_coupon_batch" do
      coupon_batch = Sales::CouponBatch.create! valid_attributes
      get :edit, {:id => coupon_batch.to_param}, valid_session
      expect(assigns(:sales_coupon_batch)).to eq(coupon_batch)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Sales::CouponBatch" do
        expect {
          post :create, {:sales_coupon_batch => valid_attributes}, valid_session
        }.to change(Sales::CouponBatch, :count).by(1)
      end

      it "assigns a newly created sales_coupon_batch as @sales_coupon_batch" do
        post :create, {:sales_coupon_batch => valid_attributes}, valid_session
        expect(assigns(:sales_coupon_batch)).to be_a(Sales::CouponBatch)
        expect(assigns(:sales_coupon_batch)).to be_persisted
      end

      it "redirects to the created sales_coupon_batch" do
        post :create, {:sales_coupon_batch => valid_attributes}, valid_session
        expect(response).to redirect_to(Sales::CouponBatch.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved sales_coupon_batch as @sales_coupon_batch" do
        post :create, {:sales_coupon_batch => invalid_attributes}, valid_session
        expect(assigns(:sales_coupon_batch)).to be_a_new(Sales::CouponBatch)
      end

      it "re-renders the 'new' template" do
        post :create, {:sales_coupon_batch => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested sales_coupon_batch" do
        coupon_batch = Sales::CouponBatch.create! valid_attributes
        put :update, {:id => coupon_batch.to_param, :sales_coupon_batch => new_attributes}, valid_session
        coupon_batch.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested sales_coupon_batch as @sales_coupon_batch" do
        coupon_batch = Sales::CouponBatch.create! valid_attributes
        put :update, {:id => coupon_batch.to_param, :sales_coupon_batch => valid_attributes}, valid_session
        expect(assigns(:sales_coupon_batch)).to eq(coupon_batch)
      end

      it "redirects to the sales_coupon_batch" do
        coupon_batch = Sales::CouponBatch.create! valid_attributes
        put :update, {:id => coupon_batch.to_param, :sales_coupon_batch => valid_attributes}, valid_session
        expect(response).to redirect_to(coupon_batch)
      end
    end

    describe "with invalid params" do
      it "assigns the sales_coupon_batch as @sales_coupon_batch" do
        coupon_batch = Sales::CouponBatch.create! valid_attributes
        put :update, {:id => coupon_batch.to_param, :sales_coupon_batch => invalid_attributes}, valid_session
        expect(assigns(:sales_coupon_batch)).to eq(coupon_batch)
      end

      it "re-renders the 'edit' template" do
        coupon_batch = Sales::CouponBatch.create! valid_attributes
        put :update, {:id => coupon_batch.to_param, :sales_coupon_batch => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested sales_coupon_batch" do
      coupon_batch = Sales::CouponBatch.create! valid_attributes
      expect {
        delete :destroy, {:id => coupon_batch.to_param}, valid_session
      }.to change(Sales::CouponBatch, :count).by(-1)
    end

    it "redirects to the sales_coupon_batches list" do
      coupon_batch = Sales::CouponBatch.create! valid_attributes
      delete :destroy, {:id => coupon_batch.to_param}, valid_session
      expect(response).to redirect_to(sales_coupon_batches_url)
    end
  end

end
