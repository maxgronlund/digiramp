class Account::RecordingArtworksController < ApplicationController
  
  include RecordingsHelper
  include AccountsHelper
  before_action :access_account
  before_action :read_recording
  
  def index

    forbidden unless current_account_user.read_file?   
    @user  = current_user
    #@recording = Recording.cached_find(params[:id])
  end
  
  def show

    forbidden unless current_account_user.read_file?   
    @user  = current_user
    @recording = Recording.cached_find(params[:recording_id])
    @artwork = Artwork.cached_find(params[:id])
  end
  
  def new
    
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def destroy
    
  end
  
private
  
  def find_recording
    @recording  = Recording.cached_find(params[:recording_id])
    @account    = Account.cached_find(params[:account_id])
  end
  
  
end
