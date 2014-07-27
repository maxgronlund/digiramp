class AddOpertunityUserIdToMusicSubmissions < ActiveRecord::Migration
  def change
    add_column :music_submissions, :opportunity_user_id, :integer
    add_index  :music_submissions, :opportunity_user_id
  end
end
