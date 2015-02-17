class CmsSocialLink < ActiveRecord::Base
  belongs_to :user
  
  #def user
  #  User.cached_find(self.user_id)
  #end
  
  def view_name
    'cms_social_links'
  end
  
  def position
    cms_section.position
  end
  
  def cms_section
    CmsSection.where(cms_module_id: self.id, cms_module_type: self.class.name ).first
  end
end
