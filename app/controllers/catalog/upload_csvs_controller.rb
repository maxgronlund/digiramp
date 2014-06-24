class Catalog::UploadCsvsController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
  before_action :set_upload_csv, only: [:show, :edit, :update, :destroy]
  
  include AccountsHelper
  include CatalogsHelper
  
  before_filter :access_account
  before_filter :access_catalog

  # GET /upload_csvs
  # GET /upload_csvs.json
  def index
    
    @upload_csvs = UploadCsv.all
  end

  # GET /upload_csvs/1
  # GET /upload_csvs/1.json
  def show
  end

  # GET /upload_csvs/new
  def new
    forbidden unless current_catalog_user.create_common_work?
    @upload_csv = UploadCsv.new
  end

  # GET /upload_csvs/1/edit
  def edit
  end

  # POST /upload_csvs
  # POST /upload_csvs.json
  def create
    
    forbidden unless current_catalog_user.create_common_work?
    
    begin
      TransloaditCSVParser.add_to_common_work params[:transloadit], @catalog.id, @account.id
      flash[:info]      = { title: "Success", body: "Recording added to Common Work" }
      #redirect_to account_work_work_recordings_path(@account, @common_work )
    rescue
      flash[:danger]      = { title: "Unable to create Recording", body: "Please check if you selected a valid file" }
      #redirect_to new_account_common_work_recording_path(@account, @common_work )
    end
    
    
    
    
    
    
    
    
    
    
    
    
    
    #@upload_csv = UploadCsv.new(upload_csv_params)
    #
    #respond_to do |format|
    #  if @upload_csv.save
    #    format.html { redirect_to @upload_csv, notice: 'Upload csv was successfully created.' }
    #    format.json { render action: 'show', status: :created, location: @upload_csv }
    #  else
    #    format.html { render action: 'new' }
    #    format.json { render json: @upload_csv.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # PATCH/PUT /upload_csvs/1
  # PATCH/PUT /upload_csvs/1.json
  def update
    respond_to do |format|
      if @upload_csv.update(upload_csv_params)
        format.html { redirect_to @upload_csv, notice: 'Upload csv was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @upload_csv.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /upload_csvs/1
  # DELETE /upload_csvs/1.json
  def destroy
    @upload_csv.destroy
    respond_to do |format|
      format.html { redirect_to upload_csvs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_upload_csv
      @upload_csv = UploadCsv.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def upload_csv_params
      params.require(:upload_csv).permit(:title, :body, :user_email, :account_id, :catalog_id, :common_works_count)
    end
end
