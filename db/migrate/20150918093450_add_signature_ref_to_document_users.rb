class AddSignatureRefToDocumentUsers < ActiveRecord::Migration
  def change
    add_reference :document_users, :digital_signature, index: true
  end
end
