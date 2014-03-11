class AddRecordingsCacheToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :rec_cache_version, :integer, default: 0
  end
end
