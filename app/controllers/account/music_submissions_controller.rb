class Account::MusicSubmissionsController < ApplicationController
  before_action :set_music_request_and_submission, only: [:index, :show, :new, :edit, :update, :destroy]
  
  include AccountsHelper
  before_filter :access_account
  
  #def index
  #  @recordings     = Recording.account_search(@account, params[:query]).order('title asc').page(params[:page]).per(48)
  #end
  
  def new

  end
  
  
  
  def create
    #@music_submission = MusicSubmission.create(music_submission_params)
    #@music_submission = MusicSubmission.create( recording_id: params[:recording_id],
    #                                         music_request_id: params[:music_request_id]  
    #                                        )                 
    #redirect_to :back
  end
  
  def submit_recording
    ap params
    @music_submission = MusicSubmission.where( recording_id: params[:id],
                                                music_request_id: params[:music_request_id]  
                                              ).first_or_create( 
                                                recording_id: params[:id],
                                                music_request_id: params[:music_request_id]  
                                              )  
                                     
    @remove_button = "#add_to_request_#{params[:id]}"
    #puts '-----------------------------------------------------'
    #puts @add_to_request
    #@add_to_request
    #puts '-----------------------------------------------------'
  end

  def edit
  end

  def show
    @music_submission  = MusicSubmission.cached_find(params[:id])
    @recording         = @music_submission.recording
  end

  def destroy
    @music_submission  = MusicSubmission.cached_find(params[:id])
    @music_submission.destroy!
    redirect_to account_account_opportunity_music_request_path(@account, @opportunity, @music_request)
  end

  def update

  end
  
  def ratings
    
  end
  
private

  def music_submission_params
     params.require(:music_submission).permit!
  end
  
  # Use callbacks to share common setup or constraints between actions.
  def set_music_request_and_submission
    @music_request    = MusicRequest.cached_find(params[:music_request_id])
    @opportunity      = Opportunity.cached_find(params[:opportunity_id])
  end
  
  
end
