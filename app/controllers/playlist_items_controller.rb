class PlaylistItemsController < ApplicationController
  include AccountsHelper
  before_filter :access_to_account
  def new
    
    
    playlist_itemable_type  = ''
    playlist_itemable_id    = 0
    if(params[:recording])  
      playlist_itemable_type  = 'Recording'
      playlist_itemable_id    = params[:recording]
    end
    
    if playlist_itemable_type != ''
      PlaylistItem.create( account_id: @account.id, 
                           playlist_id: params[:playlist_id],
                           playlist_itemable_type: playlist_itemable_type, 
                           playlist_itemable_id: playlist_itemable_id
                          )
    end
    
    redirect_to :back
  end
  
  def destroy
    playlist_item = PlaylistItem.find(params[:id])
    playlist_item.destroy
    redirect_to :back
  end
end
