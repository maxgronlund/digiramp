class MoveCatalog
  
  def initialize
  end
  
  def self.move_to_account catalog, account
    catalog.account_id = account.id
    catalog.save!
    # move all the recordings to the new account
    recordings = move_recordings_from catalog, account
    move_common_works recordings, account
  end
  
  def move_recordings_from catalog, account
    move_recordings_from = CatalogItem.where(catalog_id: catalog.id)
    recordings           = catalog_items.where(catalog_itemable_type: 'Recording')
    recordings.update_all(account_id: account.id)
  end
  
  def move_common_works recordings, account
    
    recordings.each do |recording|
      common_work = account.common_work
      
    end
    
  end
  
  def move_recordings_from common_work, account
    
    
  end
  
end

