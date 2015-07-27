class Help < ActiveRecord::Base
  has_paper_trail :ignore => [:created_at, :updated_at]
  
  after_commit :flush_cache

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

  private 

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
  
  
end
