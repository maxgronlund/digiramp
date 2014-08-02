class UpdateAccountIdOnMusicSubmissions < ActiveRecord::Migration
  def up
    remove_column :music_submissions, :account_id
    add_column :music_submissions, :account_id, :integer
    add_index  :music_submissions, :account_id
  end
  
  def down
    
  end
end
