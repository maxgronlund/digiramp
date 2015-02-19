class CmsPage < ActiveRecord::Base
  belongs_to :user
  has_many :cms_sections
  has_many :comments,        as: :commentable,          dependent: :destroy
  
  # more states inside the doc folder
  LAYOUTS = [ 'Alabama',
              'Alaska',
              'Arizona',
              'Arkansas',
              'California']
              
  THEMES = [ 'Default',
             'Black']
  
  after_commit :flush_cache

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

private 

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end

end
