class TransloaditParser
  
  def initialize
  end
  
  def self.update recording, uploads
    write_recording( recording, extract(uploads).first )
  end
  
  def self.extract uploads
    transloadets  = []
    #upload_ids    = []
    resoult_id   = []
    
    begin
      # thumbnail
      uploads[:results][:thumbnail].each do |thumbnail|
        transloadets << {thumbnail: thumbnail[:url]}
        resoult_id << thumbnail[:original_id]

      end
      
      # waveform
      uploads[:results][:waveform].each_with_index do |waveform, index|
        transloadets[index][:waveform] = waveform[:url]
      end
      # metadata
      uploads[:results][:mp3].each_with_index do |mp3, index|
        transloadets[index][:mp3] = mp3[:url]
      end
      
      position = 0
      # asuming the order is right
      # this has to be in the resoult asap
      uploads[:uploads].each do |upload|
        
        # only use success full transloads
        if resoult_id[position] == upload[:id]
          meta =  upload[:meta]
          # remove curupted iTunes info
          comment = meta[:comment].to_s 
          comment = '' if comment.include?('(iTunSMPB)')
        
          transloadets[position][:title]     = meta[:title].to_s 
          transloadets[position][:duration]  = meta[:duration].to_f.round(2)
          transloadets[position][:lyrics]    = meta[:lyrics].to_s.gsub(/\//, '<br>')
          transloadets[position][:bpm]       = meta[:beats_per_minute].to_i
          transloadets[position][:album]     = meta[:album].to_s 
          transloadets[position][:year]      = meta[:year].to_s 
          transloadets[position][:genre]     = meta[:genre].to_s 
          transloadets[position][:artist]    = meta[:artist].to_s 
          transloadets[position][:comment]   = comment 
          transloadets[position][:performer] = meta[:performer].to_s 
          transloadets[position][:band]      = meta[:band].to_s 
          transloadets[position][:disc]      = meta[:disc].to_s 
          transloadets[position][:track]     = meta[:track].to_s 
          position += 1
        end
      end
      
      
      uploads[:results][:mp3].each_with_index do |mp3, index|
        transloadets[index][:original_file_name] = mp3[:name]
      end
      
      uploads[:results][:mp3].each_with_index do |mp3, index|
        transloadets[index][:original_name] = mp3[:original_basename]
      end
      
      uploads[:results][:mp3].each_with_index do |mp3, index|
        transloadets[index][:mp3] = mp3[:url]
      end
    rescue
    end
    
    
    transloadets
  end
  
  def self.parse_recordings uploads, account_id
    transloadets = extract( uploads )
    import_batch = ImportBatch.create(account_id: account_id, transloadit: uploads)
    
    recordings = []
    transloadets.each do |transloaded|
      recording =   Recording.create!(  title:             extract_title_from( transloaded ), 
                                        duration:          transloaded[:duration],
                                        artist:            transloaded[:artist],
                                        lyrics:            sanitize_lyrics( transloaded[:lyrics] ),
                                        bpm:               transloaded[:bpm],
                                        comment:           sanitize_comment( transloaded[:comment] ),
                                        year:              transloaded[:year],
                                        album_name:        transloaded[:album],
                                        genre:             transloaded[:genre],
                                        performer:         transloaded[:performer],
                                        band:              transloaded[:band],
                                        disc:              transloaded[:disc],
                                        track:             transloaded[:track],
                                        mp3:               transloaded[:mp3],
                                        waveform:          transloaded[:waveform],
                                        thumbnail:         transloaded[:thumbnail],
                                        #copyright:         transloaded[:copyright],
                                        #composer:          transloaded[:composer],
                                        account_id:        account_id, 
                                        import_batch_id:   import_batch.id,
                                        audio_upload:      transloaded
                                       )
      recording.extract_genres                                 
      recording.update_completeness
      recordings << recording
      CommonWork.attach( recording, account_id)
    end
    
    import_batch.recordings_count = recordings.size
    import_batch.save!
    import_batch
  
  end
  
  def self.extract_title_from transloaded
    title = transloaded[:title].to_s
    title = transloaded[:original_name]   if title.to_s == ''
    sanitize_title( title )
  end
  
  def self.sanitize_title title
    title.gsub(/(^\d{2}\s)/, '')
  end
  
  def self.sanitize_comment comment
    if comment
      return '' if comment.include? '(iTunSMPB)'
    end
    return ''
  end
  
  def self.sanitize_lyrics lyrics
    if lyrics
      return lyrics.gsub(/\//, '<br>') 
    end
    return ''
      
  end
  
  def self.write_recording recording, transloadet
    
    recording.title             = sanitize_title( transloadet[:title] )       #if recording.title.to_s       == ''
    recording.artist            = transloadet[:artist]                        #if recording.artist.to_s      == ''
    recording.lyrics            = sanitize_lyrics( transloadet[:lyrics] )     #if recording.lyrics.to_s      == ''
    recording.bpm               = transloadet[:bpm]                           #if recording.bpm.to_s         == ''
    recording.comment           = sanitize_comment( transloadet[:comment] )   #if recording.comment.to_s     == ''
    recording.year              = transloadet[:year]                          #if recording.year.to_s        == ''
    recording.album_name        = transloadet[:album]                         #if recording.album_name.to_s  == ''
    recording.genre             = transloadet[:genre]                         #if recording.genre.to_s       == ''
    recording.performer         = transloadet[:performer]                     #if recording.performer.to_s   == ''
    recording.band              = transloadet[:band]                          #if recording.band.to_s        == ''
    recording.disc              = transloadet[:disc]                          #if recording.disc.to_s        == ''
    recording.track             = transloadet[:track]                         #if recording.track.to_s       == ''
    #recording.copyright:       = transloaded[:copyright],
    #recording.composer:        = transloaded[:composer],
    recording.mp3               = transloadet[:mp3]
    recording.waveform          = transloadet[:waveform]
    recording.thumbnail         = transloadet[:thumbnail]
    recording.audio_upload      = transloadet
    recording.extract_genres
    recording.update_completeness
  end
  
  
end