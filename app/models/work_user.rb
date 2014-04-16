class WorkUser < ActiveRecord::Base
  belongs_to :common_work
  belongs_to :user
  belongs_to :account
  
  after_commit :flush_cache
  
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  def self.cached_where(common_work_id, user_id)
    Rails.cache.fetch([ 'work_user', common_work_id, user_id]) { where( common_work_id: common_work_id, 
                                                                    user_id: user_id ).first 
                                                            }
  end
  
  private
  
  def flush_cache
    Rails.cache.delete([self.class.name, id])
    Rails.cache.delete(['work_user', common_work_id, user_id])
  end
  
end
