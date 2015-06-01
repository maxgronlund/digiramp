class RecordingExtractMetadata
  
  
  def self.extract recording
    
    if audio_upload = recording.audio_upload
      if meta  = audio_upload[:meta]
        recording.title        = TransloaditParser.sanitize_title( meta[:title].to_s )    
        recording.duration     = meta[:duration].to_f.round(2)   
        recording.lyrics       = TransloaditParser.sanitize_lyrics( meta[:lyrics].to_s )        
        recording.bpm          = meta[:beats_per_minute].to_i          
        recording.album_name   = meta[:album].to_s                     
        recording.year         = meta[:year].to_s                           
        recording.genre        = meta[:genre].to_s                           
        recording.artist       = meta[:artist].to_s                          
        recording.comment      = TransloaditParser.sanitize_comment( meta[:comment].to_s )     
        recording.performer    = meta[:performer].to_s                                  
        recording.band         = meta[:band].to_s                            
        recording.disc         = meta[:disc].to_s                            
        recording.track        = meta[:track].to_s                        
        recording.save!(validate: false)  
        ap recording
      end
    end      
  end

end

