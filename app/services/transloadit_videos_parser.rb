class TransloaditVideosParser
  
  def initialize
    
  end
  
  
  
  def self.extract uploads

    
    if uploads.nil? || uploads["uploads"].nil? || uploads["results"]["mp4_video"].nil?
      puts '+++++++++++++++++++++++++++++++++++++++++++++++++'
      puts 'ERROR: Unable to extract video: uploads nil'
      puts 'In TransloaditVideosParser#extract'
      puts '+++++++++++++++++++++++++++++++++++++++++++++++++'
      return nil 
    end
    transloadets  = []
    extracted     = {}

    #puts '==================== uploads ================================='
    uploads["uploads"].each do |upload|
      
      extracted[ upload["original_id"] ] = {
                                            name:                 upload[:name], 
                                            base_name:            upload["basename"], 
                                            ext:                  upload["ext"], 
                                            size:                 upload["size"], 
                                            mime:                 upload["mime"], 
                                            video_type:           upload["type"], 
                                            md5hash:              upload["md5hash"], 
                                            original_id:          upload["original_id"], 
                                            original_basename:    upload["original_basename"], 
                                            original_md5hash:     upload["original_md5hash"], 
                                            meta:                 upload["meta"]
                                           }
      
      
    end

    uploads["results"]["mp4_video"].each do |mp4_video|
      
      extracted[ mp4_video["original_id"] ][:mp4_video_url] = mp4_video["url"] 
    
      
    end
    uploads["results"]["webm_video"].each do |webm_video|
      extracted[ webm_video["original_id"] ][:webm_video_url] =  webm_video["url"]
    end

    extracted.each do | k, v|
      transloadets << v
    end
    
    # copy meta hash in to transloaded hash
    transloadets.each do |transloadet|

      meta                                  = transloadet[:meta]
      
      transloadet[:duration]                = meta[:duration].to_f.round(2)
      transloadet[:width]                   = meta[:width].to_i
      transloadet[:height]                  = meta[:height].to_i
      transloadet[:framerate]               = meta[:framerate].to_i 
      transloadet[:video_bitrate]           = meta[:video_bitrate].to_i 
      transloadet[:overall_bitrate]         = meta[:overall_bitrate].to_i 
      transloadet[:video_codec]             = meta[:video_codec].to_s 
      transloadet[:audio_bitrate]           = meta[:audio_bitrate].to_s  
      transloadet[:audio_samplerate]        = meta[:audio_samplerate].to_i
      transloadet[:audio_channels]          = meta[:audio_channels].to_i 
      transloadet[:audio_codec]             = meta[:audio_codec].to_s  
      transloadet[:seekable]                = meta[:seekable].to_s  
      transloadet[:date_recorded]           = meta[:date_recorded].to_s  
      transloadet[:date_file_created]       = meta[:date_file_created].to_s  
      transloadet[:date_file_modified]      = meta[:date_file_modified].to_s  
      transloadet[:device_vendor]           = meta[:device_vendor].to_s  
      transloadet[:device_name]             = meta[:device_name].to_s  
      transloadet[:device_software]         = meta[:device_software].to_s  
      transloadet[:latitude]                = meta[:latitude].to_s  
      transloadet[:longitude]               = meta[:longitude].to_s  
      transloadet[:rotation]                = meta[:rotation].to_i
      transloadet[:album]                   = meta[:album].to_s  
      transloadet[:comment]                 = meta[:comment].to_s 
      transloadet[:year]                    = meta[:year].to_s 
      transloadet.delete(:meta)

    end
    
    transloadets
  end
  
  
  
  def self.parse params, account_id, video_blog_id

    transloadets  = extract( params[:transloadit] )
    

    videos  = []
    errors  = []
    if transloadets.nil?
      errors << 'No valid files uploaded'
    else
      transloadets.each do |transloaded|
      
        begin
          video =   Video.create!(    title:                params[:title],
                                      body:                 params[:body],
                                      identifyer:           params[:identifyer],
                                      account_id:           account_id,
                                      video_blog_id:        video_blog_id,
                                      duration:             transloaded[:duration],               
                                      width:                transloaded[:width],                  
                                      height:               transloaded[:height],                 
                                      framerate:            transloaded[:framerate],              
                                      video_bitrate:        transloaded[:video_bitrate],          
                                      overall_bitrate:      transloaded[:overall_bitrate],        
                                      video_codec:          transloaded[:video_codec],           
                                      audio_bitrate:        transloaded[:audio_bitrate],         
                                      audio_samplerate:     transloaded[:audio_samplerate],      
                                      audio_channels:       transloaded[:audio_channels],    
                                      audio_codec:          transloaded[:audio_codec],            
                                      seekable:             transloaded[:seekable],               
                                      date_recorded:        transloaded[:date_recorded],          
                                      date_file_created:    transloaded[:date_file_created],      
                                      date_file_modified:   transloaded[:date_file_modified],    
                                      device_vendor:        transloaded[:device_vendor],        
                                      device_name:          transloaded[:device_name],           
                                      device_software:      transloaded[:device_software],       
                                      latitude:             transloaded[:latitude],              
                                      longitude:            transloaded[:longitude],             
                                      rotation:             transloaded[:rotation],               
                                      album:                transloaded[:album],              
                                      comment:              transloaded[:comment],                
                                      year:                 transloaded[:year],                
                                      mp4_video_url:        transloaded[:mp4_video_url],                  
                                      webm_video_url:       transloaded[:webm_video_url],                  
                                      name:                 transloaded[:name],                  
                                      basename:             transloaded[:basename],                  
                                      ext:                  transloaded[:ext],                  
                                      size:                 transloaded[:size],                  
                                      mime:                 transloaded[:mime],                  
                                      video_type:           transloaded[:video_type],                  
                                      md5hash:              transloaded[:md5hash],                  
                                      original_id:          transloaded[:original_id],                  
                                      original_basename:    transloaded[:original_basename],                  
                                      original_md5hash:     transloaded[:original_md5hash]
                                    )
          
          
          
          #if account_id
          #  #add_artwork_to recording unless recording.thumbnail.nil?
          #  #recording.extract_genres                                 
          #  #recording.update_completeness
          #end
          videos << video
        rescue
          errors << "!Unable to import: #{transloaded[:name]}"
        end
      
      
      end
    end
    { videos: videos, errors: errors }
  end
  
  def self.update uploads, video
    
    transloadets  = extract( uploads )
    

    videos  = []
    errors  = []
    if transloadets.nil?
      errors << 'No valid files uploaded'
    else
      
      transloadets.each do |transloaded|
      
        begin
          
         video.update_attributes!(    duration:             transloaded[:duration],               
                                      width:                transloaded[:width],                  
                                      height:               transloaded[:height],                 
                                      framerate:            transloaded[:framerate],              
                                      video_bitrate:        transloaded[:video_bitrate],          
                                      overall_bitrate:      transloaded[:overall_bitrate],        
                                      video_codec:          transloaded[:video_codec],           
                                      audio_bitrate:        transloaded[:audio_bitrate],         
                                      audio_samplerate:     transloaded[:audio_samplerate],      
                                      audio_channels:       transloaded[:audio_channels],    
                                      audio_codec:          transloaded[:audio_codec],            
                                      seekable:             transloaded[:seekable],               
                                      date_recorded:        transloaded[:date_recorded],          
                                      date_file_created:    transloaded[:date_file_created],      
                                      date_file_modified:   transloaded[:date_file_modified],    
                                      device_vendor:        transloaded[:device_vendor],        
                                      device_name:          transloaded[:device_name],           
                                      device_software:      transloaded[:device_software],       
                                      latitude:             transloaded[:latitude],              
                                      longitude:            transloaded[:longitude],             
                                      rotation:             transloaded[:rotation],               
                                      album:                transloaded[:album],              
                                      comment:              transloaded[:comment],                
                                      year:                 transloaded[:year],                
                                      mp4_video_url:        transloaded[:mp4_video_url],                  
                                      webm_video_url:       transloaded[:webm_video_url],                  
                                      name:                 transloaded[:name],                  
                                      basename:             transloaded[:basename],                  
                                      ext:                  transloaded[:ext],                  
                                      size:                 transloaded[:size],                  
                                      mime:                 transloaded[:mime],                  
                                      video_type:           transloaded[:video_type],                  
                                      md5hash:              transloaded[:md5hash],                  
                                      original_id:          transloaded[:original_id],                  
                                      original_basename:    transloaded[:original_basename],                  
                                      original_md5hash:     transloaded[:original_md5hash]
                                    )
          
          
          
          #if account_id
          #  #add_artwork_to recording unless recording.thumbnail.nil?
          #  #recording.extract_genres                                 
          #  #recording.update_completeness
          #end
          videos << video
        rescue
          errors << "!Unable to update: #{video.title}"
        end
      
      
      end
    end
    { videos: videos, errors: errors }
  end

  #def self.add_artwork_to recording
  #
  #  artwork = Artwork.create!(  title:      recording.title,
  #                              body:       recording.comment,
  #                              account_id: recording.account_id, 
  #                              thumb:      recording.cover_art, 
  #                              file:       recording.artwork
  #                            )
  #  # add artwork to recording
  #  RecordingItem.create( itemable_type: 'Artwork', 
  #                        itemable_id:   artwork.id, 
  #                        recording_id: recording.id
  #                        )
  #  
  #  
  #end
  

  #def self.extract_title_from transloaded
  #  title = transloaded[:title].to_s
  #  title = transloaded[:original_name]   if title.to_s == ''
  #  sanitize_title( title )
  #end
  #
  #def self.sanitize_title title
  #  title.gsub(/(^\d{2}\s)/, '')
  #end
  #
  #def self.sanitize_comment comment
  #  if comment
  #    return '' if comment.include? '(iTunSMPB)'
  #  end
  #  return ''
  #end
  #
  #def self.sanitize_lyrics lyrics
  #  if lyrics
  #    return lyrics.gsub(/\//, '<br>') 
  #  end
  #  return ''
  #    
  #end
  #
  #def self.write_recording recording, transloadet
  #  
  #  recording.title             = sanitize_title( transloadet[:title] )       #if recording.title.to_s       == ''
  #  recording.artist            = transloadet[:artist]                        #if recording.artist.to_s      == ''
  #  recording.lyrics            = sanitize_lyrics( transloadet[:lyrics] )     #if recording.lyrics.to_s      == ''
  #  recording.bpm               = transloadet[:bpm]                           #if recording.bpm.to_s         == ''
  #  recording.comment           = sanitize_comment( transloadet[:comment] )   #if recording.comment.to_s     == ''
  #  recording.year              = transloadet[:year]                          #if recording.year.to_s        == ''
  #  recording.album_name        = transloadet[:album]                         #if recording.album_name.to_s  == ''
  #  recording.genre             = transloadet[:genre]                         #if recording.genre.to_s       == ''
  #  recording.performer         = transloadet[:performer]                     #if recording.performer.to_s   == ''
  #  recording.band              = transloadet[:band]                          #if recording.band.to_s        == ''
  #  recording.disc              = transloadet[:disc]                          #if recording.disc.to_s        == ''
  #  recording.track             = transloadet[:track]                         #if recording.track.to_s       == ''
  #  #recording.copyright:       = transloaded[:copyright],
  #  #recording.composer:        = transloaded[:composer],
  #  recording.mp3               = transloadet[:mp3]
  #  recording.waveform          = transloadet[:waveform]
  #  recording.thumbnail         = transloadet[:thumbnail]
  #  recording.audio_upload      = transloadet
  #  recording.extract_genres
  #  recording.update_completeness
  #end
  
  
end