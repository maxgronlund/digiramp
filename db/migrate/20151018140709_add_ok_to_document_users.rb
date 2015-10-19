class AddOkToDocumentUsers < ActiveRecord::Migration
  def change
    add_column :document_users, :ok, :boolean
  end
end
