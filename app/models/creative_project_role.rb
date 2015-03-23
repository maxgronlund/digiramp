class CreativeProjectRole < ActiveRecord::Base
  belongs_to :creative_project
  #belongs_to :creative_project_user
  
  has_many :creative_project_users, dependent: :destroy
  
  
  INSTRUMENTS = [ 'Keyboard', 
                  'Guitar', 
                  'Drums', 
                  'Percussion', 
                  'Bass', 
                  'Saxophone ', 
                  'Trumpet', 
                  'Trombone', 
                  'Flute', 
                  'Clarinet',
                  'Other'
                ]
  VOCALS       = [ 'Female', 
                    'Male', 
                    'Boy', 
                    'Girl', 
                    'Female rapper',
                    'Male rapper',
                    'Bass', 
                    'Bariton ', 
                    'Tenor', 
                    'Alt', 
                    'Sopran',
                    'Speaker',
                    'Male Speaker',
                    'Female Speaker',
                    'Other'
                ]
  

  after_commit :flush_cache

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  def aproved_creative_project_user
    return true if self.creative_project_users.where(approved_by_project_manager: true, approved_by_user: true).first
    false
  end
  
  def taken?
    return true if self.creative_project_users.where(approved_by_project_manager: true, approved_by_user: true).first
    false
  end

private 

  def flush_cache
    Rails.cache.delete([self.class.name, id])
   
  end
  
  
end


