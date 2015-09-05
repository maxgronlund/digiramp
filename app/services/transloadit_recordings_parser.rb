require 'uri'

class TransloaditRecordingsParser
  
  def initialize
    
  end
  
  def self.update recording, uploads
    write_recording( recording, extract(uploads).first )
  end
  
  def error_message uploads
    ap '+++++++++++++++++++++++++++++++++++++++++++++++++'
    ap 'ERROR: Unable to extract recordings:'
    ap 'In TransloaditRecordingsParser#extract'
    ap '+++++++++++++++++++++++++++++++++++++++++++++++++'
    Opbeat.capture_message("TransloaditRecordingsParser uploads: #{uploads}")
  end
  
  def self.extract uploads
   
    # validate uploads
    if uploads.nil? || uploads[:results].nil? ||  uploads[:results][':original'].nil?
      return nil 
    end
    transloadets  = []
    extracted     = {}
    results       = uploads[:results]
    

    # original file
    results[':original'].to_a.each do |original|
      extracted[ original[:original_id] ] =  {  original_file:        original[:ssl_url].sub('https://s3.amazonaws.com/digiramp', 'https://s3-us-west-1.amazonaws.com/digiramp'),
                                                name:                 original[:name], 
                                                original_md5hash:     original[:original_md5hash],  
                                                original_file_name:   original[:original_file_name], 
                                                ext:                  original[:ext], 
                                                ssl_url:              original[:ssl_url].sub('https://s3.amazonaws.com/digiramp', 'https://s3-us-west-1.amazonaws.com/digiramp'), 
                                                url:                  original[:url].sub('https://s3.amazonaws.com/digiramp', 'https://s3-us-west-1.amazonaws.com/digiramp'),
                                                meta:                 original[:meta]}
    end


    # thumbnail
    results[:thumbnail].to_a.each do |thumbnail|
      extracted[ thumbnail[:original_id] ][:thumbnail]     = thumbnail[:ssl_url].sub('https://s3.amazonaws.com/digiramp', 'https://s3-us-west-1.amazonaws.com/digiramp')
    end

    # waveform
    results[:waveform].to_a.each do |waveform|
      extracted[ waveform[:original_id] ][:waveform]       = waveform[:ssl_url].sub('https://s3.amazonaws.com/digiramp', 'https://s3-us-west-1.amazonaws.com/digiramp')
    end

    # mp3 file
    results[:mp3].to_a.each do |mp3|
      extracted[ mp3[:original_id] ][:mp3]                 = mp3[:ssl_url].sub('https://s3.amazonaws.com/digiramp', 'https://s3-us-west-1.amazonaws.com/digiramp')
      extracted[ mp3[:original_id] ][:original_file_name]  = mp3[:name]
      extracted[ mp3[:original_id] ][:original_name]       = mp3[:original_basename]
    end

    # zipp file
    results[:zipp].to_a.each do |zipp|
      extracted[ zipp[:original_id] ][:zipp]               = zipp[:ssl_url].sub('https://s3.amazonaws.com/digiramp', 'https://s3-us-west-1.amazonaws.com/digiramp')
    end

    # artwork_thumb
    results[:artwork_thumb].to_a.each do |artwork_thumb|
      extracted[ artwork_thumb[:original_id] ][:cover_art] = artwork_thumb[:ssl_url].sub('https://s3.amazonaws.com/digiramp', 'https://s3-us-west-1.amazonaws.com/digiramp')
    end

    # artwork 
    results[:artwork].to_a.each do |artwork|
      extracted[ artwork[:original_id] ][:artwork]         = artwork[:ssl_url].sub('https://s3.amazonaws.com/digiramp', 'https://s3-us-west-1.amazonaws.com/digiramp')
    end

    extracted.each do | k, v|
      transloadets << v
    end
    #ap '==================================================================='
    #ap transloadets
    # copy meta hash in to transloaded hash
    transloadets.each do |transloadet|
    
      meta                      = transloadet[:meta]

      
      transloadet[:title]       = meta[:title].to_s 
      transloadet[:duration]    = meta[:duration].to_f.round(2)
      transloadet[:lyrics]      = meta[:lyrics].to_s.gsub(/\//, '<br>')
      transloadet[:bpm]         = meta[:beats_per_minute].to_i
      transloadet[:album]       = meta[:album].to_s 
      transloadet[:year]        = meta[:year].to_s 
      transloadet[:genre]       = meta[:genre].to_s 
      transloadet[:artist]      = meta[:artist].to_s 
      transloadet[:comment]     = sanitize_comment( meta[:comment])
      transloadet[:performer]   = meta[:performer].to_s 
      transloadet[:band]        = meta[:band].to_s 
      transloadet[:disc]        = meta[:disc].to_s 
      transloadet[:track]       = meta[:track].to_s 
    end

    #ap '==================================================================='
    #ap transloadets
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
            add_artwork_to recording
            recording.extract_genres                                 
            recording.update_completeness
          end
          recordings << recording
        rescue => e
          errors << "!Unable to import: #{transloaded[:name]}"
          errors << "<br/>#{e}"
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
    title = transloaded[:original_file_name]  if title.blank?
    sanitize_title( title )
  end
  
  def self.sanitize_title title
    title.gsub(/(^\d{2}\s)/, '').gsub( '.mp3', '').gsub( '.MP3', '')
    title = File.basename(title, ".*")
    URI.decode(title) unless title.blank?
  end
  
  def self.sanitize_comment comment
    comments = comment.to_s.include?('iTun') ? '' : comment
    URI.decode(comments) unless comments.blank?
  end
  
  def self.sanitize_lyrics lyrics
    lyrics = URI.unescape(lyrics)
    lyrics.to_s.gsub('/', '<br/>') 
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
  

  
  
  
  def self.update uploads, recording_id

    transloadets  = extract( uploads )
    

    recordings  = []
    errors      = []
    if transloadets.nil?
      errors << 'No files uploaded'
    else
      
      transloadets.each do |transloaded|
        
        #puts '*********************************************************'
        #ap transloadets
        #puts '*********************************************************'
      
        #begin
          recording = Recording.cached_find(recording_id)
          
          #recording.title               = extract_title_from( transloaded )
          #recording.duration            = transloaded[:duration]
          #recording.artist              = transloaded[:artist]
          #recording.lyrics              = sanitize_lyrics( transloaded[:lyrics] )
          #recording.bpm                 = transloaded[:bpm],
          #recording.comment             = sanitize_comment( transloaded[:comment] )
          #recording.year                = transloaded[:year]
          #recording.album_name          = transloaded[:album]
          #recording.genre               = transloaded[:genre]
          #recording.performer           = transloaded[:performer]
          #recording.band                = transloaded[:band]
          #recording.disc                = transloaded[:disc]
          #recording.track               = transloaded[:track]
          recording.mp3                 = transloaded[:mp3]
          recording.waveform            = transloaded[:waveform]
          recording.thumbnail           = transloaded[:thumbnail]
          #recording.#copyright:           transloaded[:copyright],
          #recording.#composer:            transloaded[:composer],
          #recording.account_id          = account_id
          recording.audio_upload        = transloaded
          recording.original_file       = transloaded[:original_file]
          #recording.cover_art           = transloaded[:cover_art]
          recording.artwork             = transloaded[:artwork]
          recording.ssl_url             = transloaded[:ssl_url]
          recording.url                 = transloaded[:url]
          recording.ext                 = transloaded[:ext]
          recording.original_file_name  = transloaded[:original_file_name]
          #recording.in_bucket           = in_bucket
          recording.zipp                = transloaded[:zipp]
          #recording.user_id             = user_id
          recording.save!                                 
          
          
          
          #if account_id
          #  add_artwork_to recording
          #  recording.extract_genres                                 
          #  recording.update_completeness
          #end
          recordings << recording
        #rescue
        #  errors << "!Unable to import: #{transloaded[:name]}"
        #end
      
      
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

end