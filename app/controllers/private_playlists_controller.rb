class PrivatePlaylistsController < ApplicationController
  before_filter :there_is_access_to_the_account
  
  def index
  end

  def show
    
    #@account      = Account.cached_find(params[:account_id])
    @playlist_key     = PlaylistKey.where(password: params[:id]).first
    @playlist         = @playlist_key.playlist
    @playlist_items   = @playlist.playlist_items

  end
  
  def create
    
    @account_user                     = AccountUser.cached_find(params[:account_user_id])
                                      
    @customer_event                   = CustomerEvent.new
    @customer_event.event_type        = params[:event_type]
    @customer_event.action_type       = 'compose_invitation_email'
    @customer_event.account_id        = @account.id
    @customer_event.account_user_id   = @account_user.id
    @customer_event.save!
 
    redirect_to edit_account_customer_customer_event_path(params[:account_id],params[:account_user_id], @customer_event.id )
  end
  
  def edit
    
  end
  
  def create_playlist
    
  end
  
end
