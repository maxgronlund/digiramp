class AddLegalNameToDocumentUsers < ActiveRecord::Migration
  def change
    add_column :document_users, :legal_name, :string
    add_column :document_users, :font, :string
    add_column :document_users, :signed_on, :date
  end
end
