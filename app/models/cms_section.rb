class CmsSection < ActiveRecord::Base
  belongs_to :cms_page
  belongs_to :cms_module, polymorphic: true
  
  MODULE_TYPES = ['Banner', 'Recording', 'Horizontal links', 'Vertical links', 'Playlist link', 'Video snippet', 'Text', 'Playlist', 'Comment', 'Comment', 'Social links']
  
  before_destroy :remove_module
  after_commit :flush_cache
  
  def view
    self.cms_module
  end

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

private 

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
  
  def remove_module
    begin
      cms_module.destroy!
    rescue
    end
  end
end
