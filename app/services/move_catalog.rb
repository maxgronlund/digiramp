class MoveCatalog
  
  def initialize
  end
  
  def self.move_to_account catalog, account
    
    puts catalog.title
    puts catalog.account_id
    puts account.id
    
    # move catalog to account
    catalog.account_id = account.id
    catalog.save!
    catalog.catalog_users.delete_all
    

    # move all the recordings to the new account
    move_recordings_from catalog
    
    
  end
  
  def self.move_recordings_from catalog
    
    recording_ids     = catalog.catalog_items.where(catalog_itemable_type: 'Recording').pluck(:catalog_itemable_id)
    recordings        = Recording.where(id: recording_ids)
    recordings.update_all(account_id: catalog.account_id)

  end
  

  
end

