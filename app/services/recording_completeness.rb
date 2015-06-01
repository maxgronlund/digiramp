class RecordingCompleteness
  
  
  def self.update recording
    
    recording.completeness_in_pct = 0
    recording.completeness_in_pct += 4 unless recording.isrc_code.to_s             == ''                 
    recording.completeness_in_pct += 4 unless recording.artist.to_s                == ''                    
    recording.completeness_in_pct += 4 unless recording.lyrics.to_s                == ''                    
    recording.completeness_in_pct += 4 unless recording.bpm.to_s                   == '0'                       
    recording.completeness_in_pct += 4 unless recording.comment.to_s               == ''                                      
    recording.completeness_in_pct += 4 unless recording.copyright.to_s             == ''              
    recording.completeness_in_pct += 4 unless recording.production_company.to_s    == ''         
    recording.completeness_in_pct += 4 unless recording.album_artist.to_s          == ''     
    recording.completeness_in_pct += 4 unless recording.album_title.to_s           == ''     
    recording.completeness_in_pct += 4 unless recording.grouping.to_s              == ''     
    recording.completeness_in_pct += 4 unless recording.composer.to_s              == ''     
    recordingf.completeness_in_pct+= 4 unless recording.compilation.to_s           == ''     
    recording.completeness_in_pct += 4 unless recording.year.to_s                  == ''                   
    recording.completeness_in_pct += 4 unless recording.duration.to_s              == ''               
    recording.completeness_in_pct += 4 unless recording.album_name.to_s            == ''             
    recording.completeness_in_pct += 4 unless recording.genre.to_s                 == ''                  
    recording.completeness_in_pct += 4 unless recording.performer.to_s             == ''              
    recording.completeness_in_pct += 4 unless recording.band.to_s                  == ''                   
    recording.completeness_in_pct += 4 unless recording.disc.to_s                  == ''                   
    recording.completeness_in_pct += 4 unless recording.track.to_s                 == ''                  
    recording.completeness_in_pct += 4 unless recording.cover_art.to_s             == ''     
    recording.completeness_in_pct += 5 unless recording.vocal.to_s                 == ''                  
    recording.completeness_in_pct += 5 unless recording.mood.to_s                  == ''                   
    recording.completeness_in_pct += 5 unless recording.instruments.to_s           == ''            
    recording.completeness_in_pct += 5 unless recording.tempo.to_s                 == '' 
    recording.cache_version += 1
    recording.save!(validate: false)
    
  end
end

