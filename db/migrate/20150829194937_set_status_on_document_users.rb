class SetStatusOnDocumentUsers < ActiveRecord::Migration
  def change
    DocumentUser.where(status: nil).update_all(status: 0)
    change_column :document_users, :status, :integer, default: 0
  end
end
