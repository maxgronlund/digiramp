class Message < ActiveRecord::Base
  
  after_commit :flush_cache
  
  
  
  def sender
    begin
      User.cached_find(self.sender_id)
    rescue
      nil
    end
  end
  
  def receiver
    begin
      User.cached_find(self.sender_id)
    rescue
      nil
    end
  end
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

private 

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
      
end





