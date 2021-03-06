class CmsComment < ActiveRecord::Base
  
  
  def view_name
    'cms_comment'
  end
  
  def position
    cms_section.position
  end
  
  def position=(pos)
    cms_section.position = pos
  end
  
  def cms_section
    CmsSection.where(cms_module_id: self.id, cms_module_type: self.class.name ).first
  end
  
end
