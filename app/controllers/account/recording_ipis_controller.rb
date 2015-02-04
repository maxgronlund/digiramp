class Account::RecordingIpisController < ApplicationController
  before_action :set_recording_ipi, only: [:show, :edit, :update, :destroy]
  
  
  include AccountsHelper
  before_filter :access_account
  

  # GET /recording_ipis
  # GET /recording_ipis.json
  def index
    @recording = Recording.cached_find(params[:recording_id])

  end

  # GET /recording_ipis/1
  # GET /recording_ipis/1.json
  def show
  end

  # GET /recording_ipis/new
  def new
    @recording_ipi = RecordingIpi.new
    @recording = Recording.cached_find(params[:recording_id])
  end

  # GET /recording_ipis/1/edit
  def edit
    @recording = Recording.cached_find(params[:recording_id])
  end

  # POST /recording_ipis
  # POST /recording_ipis.json
  def create
    @recording      = Recording.cached_find(params[:recording_id])
    @recording_ipi  = RecordingIpi.create(recording_ipi_params)
    redirect_to account_account_recording_recording_ipis_path(@account, @recording)

    #respond_to do |format|
    #  if @recording_ipi.save
    #    format.html { redirect_to @recording_ipi, notice: 'Recording ipi was successfully created.' }
    #    format.json { render :show, status: :created, location: @recording_ipi }
    #  else
    #    format.html { render :new }
    #    format.json { render json: @recording_ipi.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # PATCH/PUT /recording_ipis/1
  # PATCH/PUT /recording_ipis/1.json
  def update
    @recording      = Recording.cached_find(params[:recording_id])
    @recording_ipi.update(recording_ipi_params)

    redirect_to account_account_recording_recording_ipis_path( @account, @recording)

  end

  # DELETE /recording_ipis/1
  # DELETE /recording_ipis/1.json
  def destroy
    @recording      = Recording.cached_find(params[:recording_id])
    @recording_ipi.destroy
    redirect_to account_account_recording_recording_ipis_path(@account, @recording)
    #respond_to do |format|
    #  format.html { redirect_to recording_ipis_url, notice: 'Recording ipi was successfully destroyed.' }
    #  format.json { head :no_content }
    #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recording_ipi
      @recording = Recording.cached_find(params[:recording_id])
      @recording_ipi = RecordingIpi.cached_find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recording_ipi_params
      params.require(:recording_ipi).permit!
    end
end
