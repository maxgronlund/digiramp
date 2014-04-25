class AddEditRecordingsToCatalogUsers < ActiveRecord::Migration
  def change
    add_column :catalog_users, :edit_recordings, :boolean     , default: false
    add_column :catalog_users, :upload_recordings, :boolean   , default: false
    add_column :catalog_users, :read_works, :boolean          , default: false
    add_column :catalog_users, :edit_works, :boolean          , default: false
  end
end
