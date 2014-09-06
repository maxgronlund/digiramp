class WidgetTheme < ActiveRecord::Base
  
  after_commit :flush_cache
  

  def self.cached_find(id)
    return Rails.cache.fetch([name, id]) { find(id) }
  end
  
  def self.default
    WidgetTheme.where(title: 'Default')
               .first_or_create( title: 'Default')
    
  end
  
private

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
  
  
    
end
