

class RecordingCsvImporter
  
  def self.process csv_file
    
    CSV.foreach(csv_file.path, headers: true) do |row|
      recording_row = row.to_hash
      begin
        recording = Recording.cached_find(recording_row["Recording Id"].to_i)
        # make check for permissions here
        recording.account_id            = recording_row["Account Id"].to_i                unless recording_row["Account Id"].to_s.empty?
        recording.common_work_id        = recording_row["Work ID"].to_i                   unless recording_row["Work ID"].to_s.empty?
        recording.title                 = recording_row["Title"].to_s                     unless recording_row["Title"].to_s.empty?
        recording.isrc_code             = recording_row["ISRC Code"].to_s                 unless recording_row["ISRC Code"].to_s.empty?
        recording.artist                = recording_row["Artist"].to_s                    unless recording_row["Artist"].to_s.empty?
        recording.performer             = recording_row["Performer"].to_s                 unless recording_row["Performer"].to_s.empty?
        recording.band                  = recording_row["Band"].to_s                      unless recording_row["Band"].to_s.empty?
        recording.year                  = recording_row["Year"].to_s                      unless recording_row["Year"].to_s.empty?
        recording.album_name            = recording_row["Album Name"].to_s                unless recording_row["Album Name"].to_s.empty?
        recording.vocal                 = recording_row["Vocal"].to_s                     unless recording_row["Vocal"].to_s.empty?
        recording.genre                 = recording_row["Genre"].to_s                     unless recording_row["Genre"].to_s.empty?
        recording.mood                  = recording_row["Mood"].to_s                      unless recording_row["Mood"].to_s.empty?
        recording.instruments           = recording_row["Instruments"].to_s               unless recording_row["Instruments"].to_s.empty?
        recording.disc                  = recording_row["Disc"].to_s                      unless recording_row["Disc"].to_s.empty?
        recording.track                 = recording_row["Track"].to_s                     unless recording_row["Track"].to_s.empty?
        recording.bpm                   = recording_row["BPM"].to_i                       unless recording_row["BPM"].to_s.empty?
        recording.explicit              = recording_row["Explicit"].to_s       == 'true'  unless recording_row["Explicit"].to_s.empty?
        recording.clearance             = recording_row["Clearance"].to_s      == 'true'  unless recording_row["Clearance"].to_s.empty?
        recording.copyright             = recording_row["Copyright"].to_s                 unless recording_row["Copyright"].to_s.empty?
        recording.production_company    = recording_row["Production Company"].to_s        unless recording_row["Production Company"].to_s.empty?
        recording.composer              = recording_row["Composer"].to_s                  unless recording_row["Composer"].to_s.empty?
        recording.extract_genres
        recording.extract_instruments
        recording.extract_moods
        recording.get_common_work.update_completeness

      rescue
        Opbeat.capture_message("RecordingCsvParser row: #{recording_row}")
      end
    end
    
  end
end



