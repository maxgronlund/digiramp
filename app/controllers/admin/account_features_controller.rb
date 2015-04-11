class Admin::AccountFeaturesController < ApplicationController
  before_action :set_account_feature, only: [:show, :edit, :update, :destroy]
  before_filter :admin_only
  # GET /account_features
  # GET /account_features.json
  def index
    @account_features = AccountFeature.all
  end

  # GET /account_features/1
  # GET /account_features/1.json
  def show
  end

  # GET /account_features/new
  def new
    @account_feature = AccountFeature.new
  end

  # GET /account_features/1/edit
  def edit
  end

  # POST /account_features
  # POST /account_features.json
  def create
    @account_feature = AccountFeature.new(account_feature_params)
    if @account_feature.save!
      
      redirect_to admin_account_features_path
    else
      redirect_to new_admin_account_features_path(@account_feature)
    end
    
  end

  # PATCH/PUT /account_features/1
  # PATCH/PUT /account_features/1.json
  def update

    if @account_feature.update(account_feature_params)
      redirect_to admin_account_features_path
    else
      redirect_to edit_admin_account_features_path(@account_feature)
    end

  end

  # DELETE /account_features/1
  # DELETE /account_features/1.json
  def destroy
    @account_feature.destroy
    respond_to do |format|
      format.html { redirect_to account_features_url, notice: 'Account feature was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account_feature
      @account_feature = AccountFeature.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_feature_params
      params.require(:account_feature).permit!
    end
end
