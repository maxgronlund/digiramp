class Catalog< ActiveRecord::Base
  
  belongs_to :account
  has_many :catalog_items, dependent: :destroy
  has_many :catalog_users, dependent: :destroy
  #belongs_to :catalog_itemable, polymorphic: true
  #attr_accessible :catalog_itemable_type, :catalog_itemable_id, :account_catalog_id
  
  after_commit :flush_cache
  
  
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
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  def nr_recordings
    catalog_items.where(catalog_itemable_type: 'Recording').size
  end
  
private

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end

end
