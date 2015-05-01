class Admin::ZipFilesController < ApplicationController
  before_action :set_zip_file, only: [:show, :edit, :update, :destroy]
  before_action :admins_only

  # GET /zip_files
  # GET /zip_files.json
  def index
    @zip_files = ZipFile.all
  end

  # GET /zip_files/1
  # GET /zip_files/1.json
  def show
  end

  # GET /zip_files/new
  def new
    @zip_file = ZipFile.new
  end

  # GET /zip_files/1/edit
  def edit
  end

  # POST /zip_files
  # POST /zip_files.json
  def create
    @zip_file = ZipFile.new(zip_file_params)
    @zip_file.save!
    redirect_to admin_zip_files_path
    #respond_to do |format|
    #  if @zip_file.save
    #    format.html { redirect_to @zip_file, notice: 'Zip file was successfully created.' }
    #    format.json { render :show, status: :created, location: @zip_file }
    #  else
    #    format.html { render :new }
    #    format.json { render json: @zip_file.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # PATCH/PUT /zip_files/1
  # PATCH/PUT /zip_files/1.json
  def update
    @zip_file.update(zip_file_params)
    redirect_to admin_zip_files_path
    #respond_to do |format|
    #  if @zip_file.update(zip_file_params)
    #    format.html { redirect_to @zip_file, notice: 'Zip file was successfully updated.' }
    #    format.json { render :show, status: :ok, location: @zip_file }
    #  else
    #    format.html { render :edit }
    #    format.json { render json: @zip_file.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # DELETE /zip_files/1
  # DELETE /zip_files/1.json
  def destroy
    @zip_file.destroy
    redirect_to admin_zip_files_path
    #respond_to do |format|
    #  format.html { redirect_to zip_files_url, notice: 'Zip file was successfully destroyed.' }
    #  format.json { head :no_content }
    #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_zip_file
      @zip_file = ZipFile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def zip_file_params
      params.require(:zip_file).permit!
    end
end
