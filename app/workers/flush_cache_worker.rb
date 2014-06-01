class FlushCacheWorker
  include Sidekiq::Worker
  
  def perform

    Rails.cache.clear
    admin = Admin.first
    admin.version += 1
    admin.save!
    Account.all.each do |account|
      account.save!
    end
    Recording.all.each do |recording|
      
      recording.title = 'na' if recording.title.to_s == ''
      recording.save!
    end
    

    admin.flush_cache
    
    
  end
  

end