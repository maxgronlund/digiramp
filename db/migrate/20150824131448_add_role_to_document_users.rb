class AddRoleToDocumentUsers < ActiveRecord::Migration
  def change
    add_column :document_users, :role, :string
  end
end
