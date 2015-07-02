class Contract < ActiveRecord::Base
  has_paper_trail
  belongs_to :account
  belongs_to :user
  after_commit :flush_cache
  
  
  TYPES = ['Blank','Template 1', 'Template 2']
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

private 

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
  
end
