class Project < ActiveRecord::Base
  belongs_to :account
  belongs_to :user
  has_many :project_tasks, dependent: :destroy
  has_many :mail_campaigns, dependent: :destroy
  after_commit :flush_cache
  
  STAGES = ["Planning", "Started", "Running", "Evaluation", "Closed"]
  CATEGORIES = ["Sales", "Acquisition", "Promotion", "Collaboration", "Invitation", "Request", "Other"]
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
private

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
end
