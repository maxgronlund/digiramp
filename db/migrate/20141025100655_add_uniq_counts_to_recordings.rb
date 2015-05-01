class AddUniqCountsToRecordings < ActiveRecord::Migration
  def change
    add_column :recordings, :uniq_playbacks_count,  :string, default: ''
    add_column :recordings, :uniq_likes_count,      :string, default: ''
    
    Recording.find_each do |recording|
      recording.uniq_playbacks_count  = recording.playbacks_count.to_uniq
      recording.uniq_likes_count      = recording.likes_count.to_uniq
      recording.save
    end
  end
end
