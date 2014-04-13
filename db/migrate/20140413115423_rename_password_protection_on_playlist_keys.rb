class RenamePasswordProtectionOnPlaylistKeys < ActiveRecord::Migration
  def change
    rename_column :playlist_keys, :password_protection,  :secure_access 
  end
  
  def secure_access?
    self.secure_access 
  end
end
