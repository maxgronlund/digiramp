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

    respond_to do |format|
      if @account_feature.save
        format.html { redirect_to @account_feature, notice: 'Account feature was successfully created.' }
        format.json { render :show, status: :created, location: @account_feature }
      else
        format.html { render :new }
        format.json { render json: @account_feature.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account_features/1
  # PATCH/PUT /account_features/1.json
  def update
    respond_to do |format|
      if @account_feature.update(account_feature_params)
        format.html { redirect_to @account_feature, notice: 'Account feature was successfully updated.' }
        format.json { render :show, status: :ok, location: @account_feature }
      else
        format.html { render :edit }
        format.json { render json: @account_feature.errors, status: :unprocessable_entity }
      end
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
      params.require(:account_feature).permit(:account_type, :max_recordings, :enable_catalogs, :max_catalogs, :max_catalog_users, :multiply_recordings_on_works, :export_works_as_csv, :import_works_as_csv, :import_from_pros, :manage_opportunities, :max_account_users, :max_ipi_codes)
    end
end
