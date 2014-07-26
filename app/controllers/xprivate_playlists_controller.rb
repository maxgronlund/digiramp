class PrivatePlaylistsController < ApplicationController
  include AccountsHelper
  before_filter :access_account, only: [:create]
  
  def index
  end

  def show
    
    @account          = Account.cached_find(params[:account_id])
    @playlist_key     = PlaylistKey.where(playlist_url: params[:id]).first
    @playlist         = @playlist_key.playlist
    @playlist_items   = @playlist.playlist_items
    
    # pessimistic locking
    @show_login       = true
    
    if current_user && current_user.can_manage('addministrate playlists',  @playlist )
      login @playlist_key
    elsif @playlist_key.has_public_access?
      login @playlist_key
    end
    
    if loggedin @playlist_key
      @show_login       = false
    end
    #logout @playlist_key
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
  
  def update
    @playlist_key = PlaylistKey.find(params[:playlist_key][:playlist_key_id])
    @account      = Account.cached_find(params[:account_id])
    
    if  @playlist_key.password ==  params[:playlist_key][:password]
      if @playlist_key.expires 
        if @playlist_key.expiration_date > Time.now
          login @playlist_key
        else
          logout @playlist_key
        end
      else
        login @playlist_key
      end
    else
      logout @playlist_key
    end
    redirect_to account_private_playlist_path(@account, @playlist_key.playlist_url)
  end
  
  def destroy
    @playlist_key = PlaylistKey.find(params[:id])
    @account      = Account.cached_find(params[:account_id])
    logout @playlist_key
    redirect_to :back
  end
  
private
  def logout playlist_key
    session[ playlist_key.playlist_url.to_sym ] = nil
  end
  
  def login playlist_key
    session[playlist_key.playlist_url.to_sym] = playlist_key.playlist_url
  end
  
  def loggedin playlist_key
    session[playlist_key.playlist_url.to_sym]
  end
  
  def create_playlist
    
  end
  
end
