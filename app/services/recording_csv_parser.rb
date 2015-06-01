

class RecordingCsvParser
  
  def self.process recordings
    
    CSV.generate do |csv|

      csv << ['Account Id',
              'Recording Id', 
              'Work ID', 
              'Title', 
              'ISRC Code', 
              'Artist', 
              'Performer', 
              'Band', 
              'Year', 
              'Album Name',
              'Vocal',
              'Genre', 
              'Mood', 
              'Instruments', 
              'Disc', 
              'Track', 
              'BPM', 
              'Tempo',
              'Explicit', 
              'Clearance', 
              'Copyright', 
              'Production Company',
              'Composer'  
            ]
      
      recordings.each do |recording|

        csv << [  recording.account_id, 
                  recording.id, 
                  recording.common_work_id,
                  recording.title,
                  recording.isrc_code,
                  recording.artist.to_s.squish,
                  recording.performer.to_s.squish,
                  recording.band.to_s.squish,
                  recording.year,
                  recording.album_name.to_s.squish,
                  recording.vocal,
                  recording.genre_tags_as_csv_string,
                  recording.moods_tags_as_csv_string,
                  recording.instruments_tags_as_csv_string,
                  recording.disc,
                  recording.track,
                  recording.bpm,
                  recording.tempo,
                  recording.explicit,
                  recording.clearance,
                  recording.copyright.to_s.squish,
                  recording.production_company,
                  recording.composer
                
                ]
      end
    end
  end
end



