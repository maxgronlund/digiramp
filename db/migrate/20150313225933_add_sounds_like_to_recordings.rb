class AddSoundsLikeToRecordings < ActiveRecord::Migration
  def change
    add_column :recordings, :sounds_like, :text, default: ''
    #Recording.update_all(sounds_like: '')
  end
end
