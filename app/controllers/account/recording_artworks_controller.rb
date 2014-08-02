class Account::RecordingArtworksController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
  #include RecordingsHelper
  include AccountsHelper
  before_filter :find_recording
  
  def index
    
  end
  
  def show

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
    @recording = Recording.cached_find(params[:recording_id])
    @account    = Account.cached_find(params[:account_id])
  end
  
  
end
