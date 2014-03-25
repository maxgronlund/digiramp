class TransloaditParser
  
  def initialize
  end
  
  def self.update recording, uploads
    
    
    write_recording( recording, extract(uploads).first )
  end
  
  def self.extract uploads
    transloadets = []
    
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
    
    uploads[:results][:mp3].each_with_index do |mp3, index|
      transloadets[index][:track] = mp3[:meta][:track]
    end
    
    #uploads[:results][:mp3].each_with_index do |mp3, index|
    #  transloadets[index][:composer] = mp3[:meta][:composer]
    #end
    
    uploads[:results][:mp3].each_with_index do |mp3, index|
      transloadets[index][:disc] = mp3[:meta][:disc]
    end
    
    uploads[:results][:mp3].each_with_index do |mp3, index|
      transloadets[index][:band] = mp3[:meta][:band]
    end
    
    uploads[:results][:mp3].each_with_index do |mp3, index|
      transloadets[index][:title] = mp3[:meta][:title]
    end
    
    uploads[:results][:mp3].each_with_index do |mp3, index|
      transloadets[index][:lyrics] = mp3[:meta][:lyrics]
    end
    
    uploads[:results][:mp3].each_with_index do |mp3, index|
      transloadets[index][:performer] = mp3[:meta][:performer]
    end
    
    uploads[:results][:mp3].each_with_index do |mp3, index|
      transloadets[index][:comment] = mp3[:meta][:comment]
    end
    
    uploads[:results][:mp3].each_with_index do |mp3, index|
      transloadets[index][:artist] = mp3[:meta][:artist]
    end
    
    uploads[:results][:mp3].each_with_index do |mp3, index|
      transloadets[index][:genre] = mp3[:meta][:genre]
    end
    
    uploads[:results][:mp3].each_with_index do |mp3, index|
      transloadets[index][:year] = mp3[:meta][:year]
    end

    uploads[:results][:mp3].each_with_index do |mp3, index|
      transloadets[index][:album] = mp3[:meta][:album]
    end
    
    uploads[:results][:mp3].each_with_index do |mp3, index|
      transloadets[index][:bpm] = mp3[:meta][:beats_per_minute]
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
    
    transloadets
  end
  
  def self.parse_recordings uploads, account_id
    
    
    transloadets = extract( uploads )
    
    
    
    import_batch = ImportBatch.create(account_id: account_id)
    #
    #
    recordings = []
    transloadets.each do |transloaded|
      title = 'na'
      title = transloaded[:title] unless transloaded[:title].to_s == ''
      title = transloaded[:original_name] unless title.to_s == ''
      recording =   Recording.create!( title:            title,
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
                                          account_id:       account_id, 
                                          import_batch_id:  import_batch.id
                                       )
      recording.update_completeness
      recordings << recording
      CommonWork.attach( recording, account_id)
      
      
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
    recording.mp3               = transloadet[:mp3]
    recording.waveform          = transloadet[:waveform]
    recording.thumbnail         = transloadet[:thumbnail]
    recording.update_completeness
  end
  
  
end