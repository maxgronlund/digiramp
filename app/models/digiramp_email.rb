class DigirampEmail < ActiveRecord::Base
  belongs_to :email_group
  belongs_to :opportunity
  
  LAYOUT = {'News mail' => 'news_email'}
  
  mount_uploader :image_1, DigirampEmailUploader
  after_commit :flush_cache

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  
  
  
  
  def send_news_emails
    self.email_group.users.in_groups_of(100) do |users|
      DigirampEmailMailer.delay.news_email( users, self.id )
    end
  end
  
  def send_opportunity_emails
    #users = [User.first]
    #DigirampEmailMailer.delay.opportunity_created( users, self.id )
    self.email_group.users.in_groups_of(100) do |users|
      DigirampEmailMailer.delay.opportunity_created( users, self.id )
    end
  end
  

private 

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
  
end


