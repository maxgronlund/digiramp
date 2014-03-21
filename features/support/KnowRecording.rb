module KnowRecordingHelper

  def create_recordings recordings_table
    recordings_table[1 .. recordings_table.length].each do |recording_row|
      
      work_title      = recording_row[0]
      title           = recording_row[1]
      account_title   = recording_row[2]
      
      artist          = recording_row[3]
      bpm             = recording_row[4]
      instrumental    = recording_row[5] == 'y'
      explicit        = recording_row[6] == 'y'

      
      account         = Account.where(title: account_title).first
      common_work     = CommonWork.where(title: work_title).first
      
      Recording.create(title: title, 
                        account_id: account.id,
                        common_work_id: common_work.id,
                        artist: artist,
                        bpm: bpm.to_i,
                        explicit: explicit,
                        instrumental: instrumental
                        )
    end
  end
  
end

World(KnowRecordingHelper)