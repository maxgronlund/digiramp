class RecordingRightsController < ApplicationController
  
  before_filter :get_user, only: [:edit, :update]
  
  def edit
    forbidden unless @authorized
    @recording      = Recording.cached_find(params[:id])
    

  end

  def update
    @recording      = Recording.cached_find(params[:id])
    @recording.update_attributes(recording_params)
    
    #redirect_to user_recording_path(@recording.user, @recording)
    redirect_to edit_user_recording_right_path(@recording.user, @recording)
  end
  
private

  def recording_params
    params.require(:recording).permit!
    
    #params.require(:common_work).permit(          :id,
    #                                              :common_work_id,
    #                                              :title,               
    #                                              :isrc_code,           
    #                                              :artist,              
    #                                              :lyrics,              
    #                                              :bpm,                 
    #                                              :comment,             
    #                                              :created_at,          
    #                                              :updated_at,          
    #                                              :account_id,
    #                                              :explicit,            
    #                                              :documents_count,     
    #                                              :file_size,
    #                                              :clearance,           
    #                                              :version,
    #                                              :copyright,           
    #                                              :production_company,  
    #                                              :available_date,
    #                                              :upc_code,            
    #                                              :track_count,
    #                                              :disk_number,
    #                                              :disk_count,
    #                                              :album_artist,
    #                                              :album_title,
    #                                              :grouping,
    #                                              :composer,            
    #                                              :compilation,
    #                                              :bitrate,
    #                                              :samplerate,
    #                                              :channels,
    #                                              :audio_upload,
    #                                              :completeness_in_pct, 
    #                                              :mp3,
    #                                              :thumbnail,
    #                                              :year,                
    #                                              :duration,            
    #                                              :album_name,          
    #                                              :genre,               
    #                                              :performer,           
    #                                              :band,                
    #                                              :disc,                
    #                                              :track,               
    #                                              :waveform,            
    #                                              :cover_art,
    #                                              :cache_version,       
    #                                              :vocal,               
    #                                              :import_batch_id,
    #                                              :mood,                
    #                                              :instruments,         
    #                                              :tempo,               
    #                                              :original_md5hash,    
    #                                              :uuid,
    #                                              :artwork,             
    #                                              :original_file,       
    #                                              :image_file_id,
    #                                              :ssl_url,             
    #                                              :url,                 
    #                                              :ext,                 
    #                                              :original_file_name,  
    #                                              :in_bucket,           
    #                                              :zipp,
    #                                              :playbacks_count,     
    #                                              :likes_count,         
    #                                              :user_id,
    #                                              :uniq_playbacks_count,
    #                                              :uniq_likes_count,    
    #                                              :privacy,             
    #                                              :acceptance_of_terms,
    #                                              :uniq_title,          
    #                                              :fb_badge,
    #                                              :downlodable,         
    #                                              :featured,            
    #                                              :orphan,              
    #                                              :transfer_code,
    #                                              :transferable,     
    #                                              recording_ipis_attributes:  [  :id, 
    #                                                                              :role,
    #                                                                              :name,
    #                                                                              :share,
    #                                                                              :user_id,
    #                                                                              :user_uuid,
    #                                                                              :recording_id,
    #                                                                              :_destroy]                  
    #  
    #                                        )
    #                                        
                                            
  end
end


