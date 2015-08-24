class UpdatePublishingAgreement < ActiveRecord::Migration
  def change
    remove_column :publishing_agreements, :document_id
    add_column :publishing_agreements, :document_id, :uuid
    
    add_index :publishing_agreements, :document_id
  end
end
