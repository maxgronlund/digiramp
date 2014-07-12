class ProjectTask < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
private

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
  
end
