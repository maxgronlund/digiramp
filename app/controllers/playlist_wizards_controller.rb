class PlaylistWizardsController < ApplicationController
  before_filter :there_is_access_to_the_account
  def index
  
  end
  
  def new
    
  end
  

  def show
    
  end

  def edit
    @playlist_key     = PlaylistKey.find(params[:id])
    @recordings       = Recording.account_search(@account, params[:query]).order('title asc').page(params[:page]).per(12)
    @add_to_playlist  = true
  end

end
