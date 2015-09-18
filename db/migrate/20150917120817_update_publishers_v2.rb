class UpdatePublishersV2 < ActiveRecord::Migration
    
  def up
    
    rename_column :publishers, :i_am_my_own_publisher, :personal_publisher
    
    
    add_column :publishing_agreements, :split, :decimal, default: 100.0
    add_column :publishing_agreements, :personal_agreement, :boolean, default: false
    add_column :publishing_agreements, :expires, :boolean, default: false
    add_column :publishing_agreements, :expiration_date, :date
    
    rename_column :publishing_agreements, :document_id, :document_uuid
    remove_column :publishing_agreements, :email
   
    
    
    
    
  end
  
  def down

    rename_column :publishers, :personal_publisher
    rename_column :publishing_agreements, :document_uuid, :document_id
    
    remove_column :publishing_agreements, :split
    remove_column :publishing_agreements, :personal_agreement
    remove_column :publishing_agreements, :expires, :boolean, default: false
    remove_column :publishing_agreements, :expiration_date, :date
    
    add_column :publishing_agreements, :email, :string
    
    
  end
end

