class CreativeProjectResource < ActiveRecord::Base
  belongs_to :creative_project
  belongs_to :creative_project_user
  belongs_to :user
  has_many :comments,        as: :commentable,          dependent: :destroy
  
  mount_uploader :file, DocumentUploader
  validates_presence_of :title
 

  after_commit :flush_cache

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

private 

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
  
end
