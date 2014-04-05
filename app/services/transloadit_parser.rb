class TransloaditParser
  
  def initialize
  end
  
  def self.update recording, uploads
    write_recording( recording, extract(uploads).first )
  end
  
  def self.extract uploads
    transloadets = []
    
    
    begin
      # thumbnail
      uploads[:results][:thumbnail].each do |thumbnail|
        transloadets << {thumbnail: thumbnail[:url]}
      end
      
      # waveform
      uploads[:results][:waveform].each_with_index do |waveform, index|
        transloadets[index][:waveform] = waveform[:url]
      end
      # metadata
      uploads[:results][:mp3].each_with_index do |mp3, index|
        transloadets[index][:mp3] = mp3[:url]
      end
      
      uploads[:uploads].each_with_index do |upload, index|
        meta =  upload[:meta]
        #puts meta
        transloadets[index][:genre]     = meta[:genre]
        transloadets[index][:track]     = meta[:track]
        transloadets[index][:disc]      = meta[:disc]
        transloadets[index][:band]      = meta[:band]
        transloadets[index][:title]     = meta[:title]
        transloadets[index][:lyrics]    = meta[:lyrics]
        transloadets[index][:performer] = meta[:performer]
        transloadets[index][:comment]   = meta[:comment]
        transloadets[index][:artist]    = meta[:artist]
        transloadets[index][:year]      = meta[:year]
        transloadets[index][:album]     = meta[:album]
        transloadets[index][:bpm]       = meta[:beats_per_minute]
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
    import_batch = ImportBatch.create(account_id: account_id)
    
    recordings = []
    transloadets.each do |transloaded|
      title = 'na'
      title = transloaded[:title] unless transloaded[:title].to_s == ''
      title = transloaded[:original_name] unless title.to_s == ''
      recording =   Recording.create!( title:            title.gsub(/(^\d{2}\s)/, ''),
                                       artist:           transloaded[:artist],
                                       lyrics:           transloaded[:lyrics],
                                       bpm:              transloaded[:bpm],
                                       comment:          transloaded[:comment],
                                       year:             transloaded[:year],
                                       album_name:       transloaded[:album],
                                       genre:            transloaded[:genre],
                                       performer:        transloaded[:performer],
                                       band:             transloaded[:band],
                                       disc:             transloaded[:disc],
                                       track:            transloaded[:track],
                                       mp3:              transloaded[:mp3],
                                       waveform:         transloaded[:waveform],
                                       thumbnail:        transloaded[:thumbnail],
                                       #copyright:        transloaded[:copyright],
                                       #composer:         transloaded[:composer],
                                       account_id:       account_id, 
                                       import_batch_id:  import_batch.id,
                                       audio_upload:     transloaded
                                       )
      recording.update_completeness
      recordings << recording
      CommonWork.attach( recording, account_id)
      
      
      #Rails.logger.debug '----------------------------------------------------------------'
      #Rails.logger.debug recording.audio_upload
      #Rails.logger.debug '----------------------------------------------------------------'
      
    end
    
    import_batch.recordings_count = recordings.size
    import_batch.save!
    import_batch
  
  end
  
  def self.write_recording recording, transloadet
    recording.title             = transloadet[:title]       if recording.title.to_s       == ''
    recording.artist            = transloadet[:artist]      if recording.artist.to_s      == ''
    recording.lyrics            = transloadet[:lyrics]      if recording.lyrics.to_s      == ''
    recording.bpm               = transloadet[:bpm]         if recording.bpm.to_s         == ''
    recording.comment           = transloadet[:comment]     if recording.comment.to_s     == ''
    recording.year              = transloadet[:year]        if recording.year.to_s        == ''
    recording.album_name        = transloadet[:album]       if recording.album_name.to_s  == ''
    recording.genre             = transloadet[:genre]       if recording.genre.to_s       == ''
    recording.performer         = transloadet[:performer]   if recording.performer.to_s   == ''
    recording.band              = transloadet[:band]        if recording.band.to_s        == ''
    recording.disc              = transloadet[:disc]        if recording.disc.to_s        == ''
    recording.track             = transloadet[:track]       if recording.track.to_s       == ''
    #recording.copyright:       = transloaded[:copyright],
    #recording.composer:        = transloaded[:composer],
    recording.mp3               = transloadet[:mp3]
    recording.waveform          = transloadet[:waveform]
    recording.thumbnail         = transloadet[:thumbnail]
    recording.update_completeness
  end
  
  
end