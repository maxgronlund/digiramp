class ProjectTask < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  
  after_commit :flush_cache
  
  CATAGORY = ["Email", "Follow Up", "Meeting", "Phone Call", "To Do"]
  STATUS = ["Not Started", "In Progress", "Completed", "Deferred", "Waiting On Someone Else"]
  PRIORITY = ["Urgent", "High Priority", "Medium Priority", "Low Priority"]
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
private

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
  
end
