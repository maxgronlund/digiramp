module KnowRecordingHelper

  def create_recordings recordings_table
    recordings_table[1 .. recordings_table.length].each do |recording_row|
      
      work_title          = recording_row[0]
      title               = recording_row[1]
      account_title       = recording_row[2]
      artist              = recording_row[3]
      bpm                 = recording_row[4]
      explicit            = recording_row[5] == 'y'
      clearance           = recording_row[6] == 'y'
      copyright           = recording_row[7]
      upc_code            = recording_row[8]
      year                = recording_row[9]
      album_name          = recording_row[10]
      genre               = recording_row[11]
      band                = recording_row[12]
      performer           = recording_row[13]
      
      account         = Account.where(title: account_title).first
      common_work     = CommonWork.where(title: work_title).first
      
      Recording.create(title: title, 
                        account_id: account.id,
                        common_work_id: common_work.id,
                        artist: artist,
                        bpm: bpm.to_i,
                        explicit: explicit,
                       
                        )
      common_work.update_completeness
    end
  end
  
end

World(KnowRecordingHelper)