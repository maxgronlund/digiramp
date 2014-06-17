class Artwork < ActiveRecord::Base
  
  belongs_to :account
  
  after_commit :flush_cache
  
  before_destroy :remove_from_items
  
  def remove_from_items
    if catalog_items = CatalogItem.where(catalog_itemable_id: self.id, catalog_itemable_type: 'Artwork')
      catalog_items.destroy_all
    end
  end

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
private
  
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end

end
