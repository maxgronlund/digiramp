class Account::MusicRequestsController < ApplicationController
  before_action :set_music_request, only: [:show, :edit, :update, :destroy, :find_recording, :upload_recording]
  include Transloadit::Rails::ParamsDecoder
  include ActionView::Helpers::TextHelper
  include AccountsHelper
  before_action :access_account

  # GET /opportunities
  # GET /opportunities.json
  def index
    forbidden unless current_account_user.read_opportunity
    
    #@opportunities = Opportunity.all
  end


  def show
    forbidden unless current_account_user.read_opportunity
    @opportunity    = Opportunity.cached_find(params[:opportunity_id])
    @user           = current_user
    @playlists      = current_user.playlists
  end

  # GET /opportunities/new
  def new
    forbidden unless current_account_user.update_opportunity
    @opportunity    = Opportunity.cached_find(params[:opportunity_id])
    @music_request  = MusicRequest.new
    @user           = current_user
  end

  # GET /opportunities/1/edit
  def edit
    forbidden unless current_account_user.update_opportunity
    @opportunity    = Opportunity.cached_find(params[:opportunity_id])
    @user           = current_user
  end


  def create
    forbidden unless current_account_user.update_opportunity
    @opportunity         = Opportunity.cached_find(params[:opportunity_id])
    initialize_recording  TransloaditRecordingsParser.parse( params[:transloadit], 
                                                              current_account_user.account.id, 
                                                              true, 
                                                              current_account_user.user_id)
    
    
    if @music_request = MusicRequest.create(music_request_params)
      redirect_to account_account_opportunity_path(@account, @opportunity)
    else
      render :new
    end

  end

  def update
    # '============================= update =================================='
    forbidden unless current_account_user.update_opportunity
    @opportunity         = Opportunity.cached_find(params[:opportunity_id])
    initialize_recording  TransloaditRecordingsParser.parse( params[:transloadit], 
                                                              current_account_user.account.id, 
                                                              true, 
                                                              current_account_user.user_id)
    
    # params
    # music_request_params
    if @music_request.update(music_request_params)
      redirect_to account_account_opportunity_path(@account, @opportunity)
    else
      render :edit
    end

  end
  
  def initialize_recording result
    # '==============================================================='
    # result[:recordings][0]
    begin
      
     # success mesage
     unless result[:recordings].size == 0
       flash[:info]      = "#{pluralize(result[:recordings].size, "File")} uploaded" 
       # fetch recording id
       recording_id = result[:recordings][0].id
       # make sure recording is not shown public
       hide_recording recording_id
       # assign the recording id to the request
       params[:music_request][:recording_id] = recording_id
     end
     # error messages
     if result[:errors].size > 0 && result[:errors][0] != 'No files uploaded'
       errors     = ''
       nr_errors = 0
       result[:errors].each do |error|
         nr_errors += 1
         errors << error + '<br>'
       end
       flash[:danger]    = errors 
     end
    rescue
      #flash[:danger]      = "Unable to create Recording! Please check if you selected a valid file" 
      #redirect_to new_account_account_audio_file_path(@account, @common_work )
    end
  end
  
  def hide_recording recording_id
    if recording = Recording.cached_find(recording_id)
      recording.mount_common_work
      recording.account_id          = User.system_user.account.id
      recording.user_id             = User.system_user.id
      recording.clearance           = false
      recording.orphan              = true
      recording.all_ipis_confirmed  = false
      recording.pre_cleared         = false
      recording.in_shop             = false
      recording.valid_for_sale      = false
      recording.privacy             = 'Only me'
      recording.save!
      
    else
      # '=========================================================='
      # "============= #{recording_id} ============================"
      # '=========================================================='
    end
    
  end


  def destroy
    forbidden unless current_account_user.delete_opportunity
    opportunity = @music_request.opportunity
    @music_request.destroy
    redirect_to account_account_opportunity_path(@account, opportunity)
  end
  

  
  def max_submissions_reached 
    
  end

  
  def upload_recording
    forbidden unless current_account_user.create_recording?
    @opportunity    = Opportunity.cached_find(params[:opportunity_id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_music_request
      @music_request = MusicRequest.cached_find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def music_request_params
      params.require(:music_request).permit!
    end
end
