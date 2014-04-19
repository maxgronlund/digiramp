class CatalogUser < ActiveRecord::Base
  belongs_to :catalog
  belongs_to :user
  belongs_to :account
  belongs_to :catalog
  
  after_commit :flush_cache
  
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  def self.cached_where(catalog_id, user_id)
    Rails.cache.fetch([ 'catalog_user', catalog_id, user_id]) { where( catalog_id: catalog_id, 
                                                                    user_id: user_id ).first 
                                                            }
  end
  
private
  
  def flush_cache
    Rails.cache.delete([self.class.name, id])
    Rails.cache.delete(['catalog_user', catalog_id, user_id])
  end
  
  
  
end
