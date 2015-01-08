class RemoveMp3FromRecordingTitles < ActiveRecord::Migration
  def change
    Recording.find_each do |rec|
      

      if rec.title.end_with?('.mp3')
        rec.title = rec.title.gsub( '.mp3', '')
        rec.save!
      elsif rec.title.end_with?('.MP3')
        rec.title = rec.title.gsub( '.MP3', '')
        rec.save!
      end

        
    end
  end
end
