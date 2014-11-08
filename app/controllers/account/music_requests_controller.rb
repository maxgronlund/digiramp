class Account::MusicRequestsController < ApplicationController
  before_action :set_music_request, only: [:show, :edit, :update, :destroy, :find_recording, :upload_recording]
  include Transloadit::Rails::ParamsDecoder
  include ActionView::Helpers::TextHelper
  include AccountsHelper
  #before_filter :access_account
  before_filter :get_account_account

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
    @opportunity    = Opportunity.cached_find(params[:opportunity_id])
    
    
    begin
     result = TransloaditRecordingsParser.parse params[:transloadit],  current_account_user.account_id, true, current_account_user.user_id
     # success mesage
     unless result[:recordings].size == 0
       flash[:info]      = { title: "Succes", body: "#{pluralize(result[:recordings].size, "File")} uploaded" }
       # fetch recording id
       recording_id = result[:recordings][0].id
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
       flash[:danger]    = { title: "Errors", body: errors }
     end
    rescue
      flash[:danger]      = { title: "Unable to create Recording", body: "Please check if you selected a valid file" }
      #redirect_to new_account_account_audio_file_path(@account, @common_work )
    end
    
    if @music_request = MusicRequest.create(music_request_params)
      redirect_to account_account_opportunity_path(@account, @opportunity)
    else
      
    end
    #
    #if @opportunity.save
    #  flash[:info]      = { title: "Success", body: "Opportunity Created" }
    #  redirect_to account_account_opportunity_path(@account, @opportunity)
    #   
    #else
    #  flash[:danger]      = { title: "Error", body: "Unable to create opportunity" }
    #  redirect_to new_account_account_opportunity_path(@account)
    #end
    #
  end

  def update
    forbidden unless current_account_user.update_opportunity
    @opportunity    = Opportunity.cached_find(params[:opportunity_id])
    
    

    
    
    #begin
     result = TransloaditRecordingsParser.parse params[:transloadit],  current_account_user.account_id , true, current_account_user.user_id
     # success mesage
     unless result[:recordings].size == 0
       flash[:info]      = { title: "Succes", body: "#{pluralize(result[:recordings].size, "File")} uploaded" }
       # fetch recording id
       recording_id = result[:recordings][0].id
       # assign the recording id to the request
       params[:music_request][:recording_id] = recording_id
     end
     # error messages
     unless result[:errors].size == 0
       errors     = ''
       nr_errors = 0
       result[:errors].each do |error|
         nr_errors += 1
         errors << error + '<br>'
       end
       flash[:danger]    = { title: "Errors", body: errors }
     end
    
    
    
     #redirect_to account_account_recordings_bucket_index_path(@account)
    #rescue
    #  flash[:danger]      = { title: "Unable to create Recording", body: "Please check if you selected a valid file" }
    #  #redirect_to new_account_account_audio_file_path(@account, @common_work )
    #end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    if @music_request.update(music_request_params)
      flash[:info]      = { title: "Success", body: "Music Request Updated" }
      redirect_to account_account_opportunity_music_request_path(@account, @opportunity, @music_request)
    else
      flash[:danger]      = { title: "Error", body: "Unable to update Music Request" }
      redirect_to new_account_account_opportunity_path(@account)
    end

  end


  def destroy
    forbidden unless current_account_user.delete_opportunity
    opportunity = @music_request.opportunity
    @music_request.destroy
    redirect_to account_account_opportunity_path(@account, opportunity)
  end
  
  #def find_recording
  #  forbidden unless current_account_user.read_recording?
  #  @opportunity    = Opportunity.cached_find(params[:opportunity_id])
  #  @recordings     = Recording.not_in_bucket.account_search(@account, params[:query]).order('title asc').page(params[:page]).per(48)
  #  
  #  #recordings_to_remove = []
  #  #@opportunity.music_requests.each do |music_request|
  #  #  music_request.music_submissions.each do |music_submission|
  #  #    recordings_to_remove << music_submission.recording
  #  #  end
  #  #end
  #  #puts '-------------------- @recordings.class.name -------------------------'
  #  #puts @recordings.class.name
  #  #puts '---------------------------------------------------------------------'
  #  #@recordings
  #  @show_more      = true
  #end
  
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
