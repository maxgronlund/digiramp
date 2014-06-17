class CatalogItem < ActiveRecord::Base
  
  belongs_to :catalog
  belongs_to :catalog_itemable, polymorphic: true
  
  after_create  :update_catalog_counter_cache
  after_destroy :update_catalog_counter_cache
  
  def update_catalog_counter_cache
    
    
    case self.catalog_itemable_type

    when 'CommonWork'
      CatalogCommonWorkCounterCachWorker.perform_async(self.catalog_id)
    when 'Recording'
      CatalogRecordingCounterCachWorker.perform_async(self.catalog_id)
    when 'Document', 'Artwork'
      CatalogDocumentCounterCachWorker.perform_async(self.catalog_id)
    end

    
  end
  #attr_accessible :catalog_itemable_type, :catalog_itemable_id, :account_catalog_id
  

  #scope :common_works,  ->  { where( catalog_itemable_type: 'CommonWork')  }
  
  
  
  #def link_to_parrent 
  #  url = ''
  #  #parrent_link = 'root_path'
  #  #
  #  #
  #  case catalog_itemable_type
  #    
  #  when 'CommenWork'
  #    common_work = CommonWork.find(catalog_itemable_id)
  #    #logger.debug '-----------------------------------------------------------------'
  #    #logger.debug common_work.account_id
  #    #logger.debug common_work.id
  #    #logger.debug '-----------------------------------------------------------------'
  #    #parrent_link = root_path
  #    ## = account_common_work_path(common_work.account_id, common_work.id)
  #    #url = url_for(common_work.account, common_work)
  #  end
  #  url
  #  
  #end
  
  

end
