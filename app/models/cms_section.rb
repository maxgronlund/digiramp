class CmsSection < ActiveRecord::Base
  belongs_to :cms_page
  belongs_to :cms_module, polymorphic: true
  
  MODULE_TYPES = [ 'Activities',
                   'Banner',
                   'Contact',
                   'Comment', 
                   'Horizontal links', 
                   'Image', 
                   'Menu bar',
                   'Playlist', 
                   'Playlist link',
                   'Profile', 
                   'Recording', 
                   'Social links', 
                   'Text',  
                   'Vertical links',  
                   'Video snippet']
  
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
