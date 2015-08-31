class RenameIWantFindAndListenToMusic < ActiveRecord::Migration
  def change
    rename_column :user_configurations, :i_want_find_and_listen_to_music, :i_want_to_find_and_listen_to_music
  end
end
