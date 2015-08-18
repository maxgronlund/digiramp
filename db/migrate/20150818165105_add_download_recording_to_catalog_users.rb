class AddDownloadRecordingToCatalogUsers < ActiveRecord::Migration
  def change
    add_column :catalog_users, :download_recording, :boolean, default: false
    add_column :account_users, :download_recording, :boolean, default: false
    ap '================================================================='
    User.supers.each do |user|
     catalog_user =  CatalogUser.find_by(id: user.super_catalog_user_id)
     catalog_user.download_recording = true
     catalog_user.save!
     ap catalog_user
     ap '--'

     account_user =  AccountUser.find_by(id: user.super_account_user_id)
     account_user.download_recording = true
     account_user.save!
     ap account_user
    end
  end
end
