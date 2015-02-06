class CmsRecording < ActiveRecord::Base
  belongs_to :recording
  
  
  def view_name
    'cms_recording'
  end
  
  def position
    cms_section.position
  end
  
  def cms_section
    CmsSection.where(cms_module_id: self.id, cms_module_type: self.class.name ).first
  end
  
  
  
end
