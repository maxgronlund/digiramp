class MailCampaign < ActiveRecord::Base
  belongs_to :account
  belongs_to :user
  belongs_to :mail_layout
  belongs_to :project
  after_commit :flush_cache
  
  STATUS =  ["Draft", "Send"]
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
private

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
end
