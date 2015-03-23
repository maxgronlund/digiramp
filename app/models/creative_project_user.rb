class CreativeProjectUser < ActiveRecord::Base
  
  belongs_to :creative_project
  belongs_to :creative_project_role
  belongs_to :user
  has_many :comments,        as: :commentable,          dependent: :destroy
  after_create :notify_project_manager
  
  has_many :creative_project_resources
  
  after_commit :flush_cache

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  def manager?
    self.creative_project_role.role == 'project manager'
  end
  
  def role
    self.creative_project_role.role
  end

private 

  def notify_project_manager
    ap self
  end


  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
  
end
