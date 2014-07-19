class AddAccountIdToMusicSubmissions < ActiveRecord::Migration
  def change
    add_column :music_submissions, :account_id, :string
    add_index :music_submissions, :account_id
    MusicSubmission.destroy_all
    
   
  end
end
