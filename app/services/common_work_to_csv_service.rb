# export all information related to a common work as a csv file
class CommonWorkToCsvService
  
  
  def self.process selector
    # please dry this up
    CSV.generate do |csv|
      #csv << column_names
      csv << ['DigiRAMP CVS', '', '', '', '', '', '' ]
      csv << ['']
      csv << ['']
      selector.each do |common_work|
        #recording_ids = ''
        #common_work.recordings.each do |recording|
        #  recording_ids << recording.id.to_s
        #  recording_ids << ','
        #end
        # work info
        csv << ['COMMON WORK']
        csv << [  '','Title', 'ISWC Code','Alternative Titles', 'Description','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',  'UUID' ]
        csv << [  '',
                  common_work.title,
                  common_work.iswc_code,
                  common_work.alternative_titles,
                  common_work.description.to_s.squish,
                  '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
                  common_work.uuid.to_s, 
                ]
        # ipis
        #if common_work.ipis.size > 0
        if true
          csv << ['' ]
          csv << ['' ]
          csv << ['IPI\'S' ]
          csv << [  '',
                    'IPI Code',
                    'Full Name',
                    'Role', 
                    'Address', 
                    'Email', 
                    'Phone Number', 
                    'Controlled', 
                    'Territory', 
                    'Share', 
                    'Mech Owned %', 
                    'Mech Collected %', 
                    'Performance Owned %', 
                    'Performance Collected %', 
                    'Notes',
                    'CAE Code',
                    '','','','','','','','','','','','','','','','','','','', 
                    'Common Work UUID',
                  ]
          common_work.ipis.each do |ipi|
            csv <<  [
                      '',
                      ipi.ipi_code.to_s,
                      ipi.full_name.to_s,
                      ipi.role.to_s,
                      ipi.address.to_s,
                      ipi.email.to_s,
                      ipi.phone_number.to_s,
                      ipi.controlled.to_s,
                      ipi.territory.to_s,
                      ipi.share.to_s,
                      ipi.mech_owned.to_s,
                      ipi.mech_collected.to_s,
                      ipi.perf_owned.to_s,
                      ipi.perf_collected.to_s,
                      ipi.notes.to_s,
                      ipi.cae_code.to_s,
                      '','','','','','','','','','','','','','','','','','', '', 
                      common_work.uuid
                    ]
          end
          # recordings
          #if common_work.recordings.size > 0
          if true
            csv << ['' ]
            csv << ['' ]
            csv << ['RECORDINGS' ]
            csv << [  '',
                      "Title",            
                      "ISRC CODE",        
                      "Artist",                   
                      "BPM",              
                      "Comment",          
                      "Explicit",         
                      "Clearance",        
                      "Version",
                      "Copyright",        
                      "Production Company",
                      "Available Date",
                      "UPC CODE",         
                      "Album Artist",
                      "Album Title",
                      "Grouping",
                      "Composer",
                      "Compilation",
                      "Bitrate",
                      "Samplerate",
                      "Channels",
                      "Year",             
                      "Duration",         
                      "Album Name",       
                      "Genre",            
                      "Performer",        
                      "Band",             
                      "Disc",             
                      "Track", 
                      "Vocal",            
                      "Mood",             
                      "instruments",      
                      "Tempo",
                      "MP3 File",
                      'UUDI', 
                      'Common Work UUID'
                    ]
            common_work.recordings.each do |recording|
              csv <<  [
                        '',
                        recording.title.to_s,            
                        recording.isrc_code.to_s,        
                        recording.artist.to_s,                   
                        recording.bpm.to_s,              
                        recording.comment.to_s,          
                        recording.explicit.to_s,         
                        recording.clearance.to_s,        
                        recording.version.to_s,
                        recording.copyright.to_s,        
                        recording.production_company.to_s,
                        recording.available_date.to_s,
                        recording.upc_code.to_s,         
                        recording.album_artist.to_s,
                        recording.album_title.to_s,
                        recording.grouping.to_s,
                        recording.composer.to_s,
                        recording.compilation.to_s,
                        recording.bitrate.to_s,
                        recording.samplerate.to_s,
                        recording.channels.to_s,
                        recording.year.to_s,             
                        recording.duration.to_s,         
                        recording.album_name.to_s,       
                        recording.genre.to_s,            
                        recording.performer.to_s,        
                        recording.band.to_s,             
                        recording.disc.to_s,             
                        recording.track.to_s,      
                        recording.vocal.to_s,            
                        recording.mood.to_s,             
                        recording.instruments.to_s,      
                        recording.tempo.to_s,
                        recording.mp3,
                        recording.uuid,
                        common_work.uuid
                      ]
              end
            end
        end
        csv << ['']
        csv << ['']
        csv << ['']
        csv << ['']
      end
    
    end
  end
  

  
end

