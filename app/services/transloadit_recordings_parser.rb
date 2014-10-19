class TransloaditRecordingsParser
  
  def initialize
    
  end
  
  def self.update recording, uploads
    write_recording( recording, extract(uploads).first )
  end
  
  def self.extract uploads
    
    if uploads.nil? || uploads[:results].nil? ||  uploads[:results][':original'].nil?
      #puts '+++++++++++++++++++++++++++++++++++++++++++++++++'
      #puts 'ERROR: Unable to extract recordings: uploads nil'
      #puts 'In TransloaditRecordingsParser#extract'
      #puts '+++++++++++++++++++++++++++++++++++++++++++++++++'
      return nil 
    end
    transloadets  = []
    extracted     = {}

    

    # original file
    uploads[:results][':original'].each do |original|
      extracted[ original[:original_id] ] =  {  original_file:        original[:url],
                                                name:                 original[:name], 
                                                original_md5hash:     original[:original_md5hash],  
                                                original_file_name:   original[:original_file_name], 
                                                ext:                  original[:ext], 
                                                ssl_url:              original[:ssl_url], 
                                                url:                  original[:url],
                                                meta:                 original[:meta]}
    end

    

    if uploads[:results][:thumbnail]
      # thumbnail
      uploads[:results][:thumbnail].each do |thumbnail|
        extracted[ thumbnail[:original_id] ][:original_file] = thumbnail[:url]
      end
    end
    
    if uploads[:results][:waveform]
      # waveform
      uploads[:results][:waveform].each do |waveform|
        extracted[ waveform[:original_id] ][:waveform]       = waveform[:url]
      end
    end
    
    
    if uploads[:results][:mp3]
      # mp3 file
      uploads[:results][:mp3].each do |mp3|
        extracted[ mp3[:original_id] ][:mp3]                 = mp3[:url]
        extracted[ mp3[:original_id] ][:original_file_name]  = mp3[:name]
        extracted[ mp3[:original_id] ][:original_name]       = mp3[:original_basename]
      end
    end
    
    if uploads[:results][:zipp]
      # zipp file
      uploads[:results][:zipp].each do |zipp|
        extracted[ zipp[:original_id] ][:zipp]               = zipp[:url]
      end
    end

    
    if uploads[:results][:artwork_thumb]
      # artwork_thumb
      unless uploads[:results][:artwork_thumb].nil?
        uploads[:results][:artwork_thumb].each do |artwork_thumb|
          extracted[ artwork_thumb[:original_id] ][:cover_art]       = artwork_thumb[:url]
        end
      end
    end
    
    if uploads[:results][:artwork]
      # artwork 
      unless uploads[:results][:artwork].nil?
        uploads[:results][:artwork].each do |artwork|
          extracted[ artwork[:original_id] ][:artwork]       = artwork[:url]
        end
      end
    end
    
    extracted.each do | k, v|
      transloadets << v
    end
    
    # copy meta hash in to transloaded hash
    transloadets.each do |transloadet|

      meta                      = transloadet[:meta]
      # remove curupted iTunes info
      comment                   = meta[:comment].to_s 
      comment                   = '' if comment.include?('(iTun')
      transloadet[:title]       = meta[:title].to_s 
      transloadet[:duration]    = meta[:duration].to_f.round(2)
      transloadet[:lyrics]      = meta[:lyrics].to_s.gsub(/\//, '<br>')
      transloadet[:bpm]         = meta[:beats_per_minute].to_i
      transloadet[:album]       = meta[:album].to_s 
      transloadet[:year]        = meta[:year].to_s 
      transloadet[:genre]       = meta[:genre].to_s 
      transloadet[:artist]      = meta[:artist].to_s 
      transloadet[:comment]     = comment 
      transloadet[:performer]   = meta[:performer].to_s 
      transloadet[:band]        = meta[:band].to_s 
      transloadet[:disc]        = meta[:disc].to_s 
      transloadet[:track]       = meta[:track].to_s 
    end
    transloadets
  end
  
  def self.parse uploads, account_id, in_bucket, user_id

    transloadets  = extract( uploads )
    

    recordings  = []
    errors      = []
    if transloadets.nil?
      errors << 'No files uploaded'
    else
      
      transloadets.each do |transloaded|
      
        begin
          recording =   Recording.create!(  title:               extract_title_from( transloaded ), 
                                            duration:            transloaded[:duration],
                                            artist:              transloaded[:artist],
                                            lyrics:              sanitize_lyrics( transloaded[:lyrics] ),
                                            bpm:                 transloaded[:bpm],
                                            comment:             sanitize_comment( transloaded[:comment] ),
                                            year:                transloaded[:year],
                                            album_name:          transloaded[:album],
                                            genre:               transloaded[:genre],
                                            performer:           transloaded[:performer],
                                            band:                transloaded[:band],
                                            disc:                transloaded[:disc],
                                            track:               transloaded[:track],
                                            mp3:                 transloaded[:mp3],
                                            waveform:            transloaded[:waveform],
                                            thumbnail:           transloaded[:thumbnail],
                                            #copyright:           transloaded[:copyright],
                                            #composer:            transloaded[:composer],
                                            account_id:          account_id, 
                                            audio_upload:        transloaded,
                                            original_file:       transloaded[:original_file],
                                            cover_art:           transloaded[:cover_art],
                                            artwork:             transloaded[:artwork],
                                            ssl_url:             transloaded[:ssl_url],
                                            url:                 transloaded[:url],
                                            ext:                 transloaded[:ext],
                                            original_file_name:  transloaded[:original_file_name],
                                            in_bucket:           in_bucket,
                                            zipp:                transloaded[:zipp],
                                            user_id:             user_id,
                                           )
          
          
          
          if account_id
            add_artwork_to recording unless recording.thumbnail.nil?
            recording.extract_genres                                 
            recording.update_completeness
          end
          recordings << recording
        rescue
          errors << "!Unable to import: #{transloaded[:name]}"
        end
      
      
      end
    end
    { recordings: recordings, errors: errors }
  end

  def self.add_artwork_to recording

    artwork = Artwork.create!(  title:      recording.title,
                                body:       recording.comment,
                                account_id: recording.account_id, 
                                thumb:      recording.cover_art, 
                                file:       recording.artwork
                              )
    # add artwork to recording
    RecordingItem.create( itemable_type: 'Artwork', 
                          itemable_id:   artwork.id, 
                          recording_id: recording.id
                          )
    
    
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