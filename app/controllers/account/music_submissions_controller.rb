class Account::MusicSubmissionsController < ApplicationController
  before_action :set_music_request_and_submission, only: [:index, :show, :new, :edit, :update, :destroy]
  
  include AccountsHelper
  before_filter :access_account
  
  #def index
  #  @recordings     = Recording.account_search(@account, params[:query]).order('title asc').page(params[:page]).per(48)
  #end
  
  def new
    @music_submission = MusicSubmission.new
  end
  
  def create
    @music_submission = MusicSubmission.create(music_submission_params)
    redirect_to :back
  end

  def edit
  end

  def show
  end

  def destroy
  end

  def update

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
