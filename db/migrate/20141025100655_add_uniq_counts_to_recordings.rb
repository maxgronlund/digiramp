class AddUniqCountsToRecordings < ActiveRecord::Migration
  def change
    add_column :recordings, :uniq_playbacks_count,  :string, default: ''
    add_column :recordings, :uniq_likes_count,      :string, default: ''
    
    Recording.find_each do |recording|
      recording.uniq_playbacks_count  = Uniqifyer.uniqify(recording.playbacks_count)
      recording.uniq_likes_count      = Uniqifyer.uniqify(recording.likes_count)
      recording.save
    end
  end
end
