class CatalogItem < ActiveRecord::Base
  include PublicActivity::Common
  belongs_to :catalog
  belongs_to :catalog_itemable, polymorphic: true
  

  
  def self.cached_find(id)
    begin
      return Rails.cache.fetch([name, id]) { find(id) }
    rescue
      return nil
    end
  end

private
  
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end

end
