class CatalogItem < ActiveRecord::Base
  
  belongs_to :catalog
  belongs_to :catalog_itemable, polymorphic: true
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
