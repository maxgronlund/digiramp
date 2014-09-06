class ReatachWidgets < ActiveRecord::Migration
  def change
    
    #Playlist.destroy_all
    #Widget.all.each do |widget|
    #  if widget.secret_key.to_s.size < 10
    #    # get widgets connected to a catalog
    #    if widget.catalog_id
    #      # find catalog
    #      if catalog = Catalog.where(id: widget.catalog_id.to_i).first
    #
    #        
    #        # destroy catalog widget
    #        widget.destroy
    #        
    #        # add recordings to playlist
    #        catalog.add_recordings catalog.recordings
    #        
    #        # log resoult
    #        ap catalog.default_widget
    #        if catalog.default_widget.recordings
    #          catalog.default_widget.recordings.each do |recording|
    #            ap recording
    #          end
    #        end
    #      end
    #    else
    #      puts '--------------------------- all ready a playlist --------------------------'
    #    end
    #    
    #  end
    #  
    #end
  end
end
