class Catalog::CreatePlaylistsController < ApplicationController
  
  def show
    puts '>>>>>>>>>>>>>>>>>>>>>>>>>>>>> EXPORT <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<'
    
    catalog   = Catalog.cached_find(params[:id])
    playlist  = catalog.playlist

    catalog.recordings.each_with_index do |recording|
      playlist_item = PlaylistItem.where( playlist_id:            playlist.id,
                                          playlist_itemable_id:   recording.id, 
                                          playlist_itemable_type: 'Recording')
                                  .first_or_create( 
                                          playlist_id:            playlist.id,
                                          playlist_itemable_id:   recording.id, 
                                          playlist_itemable_type: 'Recording',
                                          position:                0)
      
                                          
    end
    
    playlist.recordings.each do |recording|
      ap recording
    end
    
    
    render nothing: true
  end
  
  def index
    puts '>>>>>>>>>>>>>>>>>>>>>>>>>>>>> INDEX <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<'
  end
  
end


