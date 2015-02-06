class CmsSection < ActiveRecord::Base
  belongs_to :cms_page
  belongs_to :cms_module, polymorphic: true
  
  MODULE_TYPES = ['Banner', 'Recording', 'Horizontal links', 'Vertical links', 'Playlist link', 'Video snippet', 'Text']
  
  before_destroy :remove_module
  
  def view
    self.cms_module
  end
  
private
  
  def remove_module
    begin
      cms_module.destroy!
    rescue
    end
  end
end
