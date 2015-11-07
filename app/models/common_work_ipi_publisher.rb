class CommonWorkIpiPublisher < ActiveRecord::Base
  include NotificationModule
  belongs_to :common_work_ipi
  belongs_to :publisher
  belongs_to :user
  belongs_to :publishing_agreement
  
  
  def do_validation
    ap 'CommonWorkIpiPublisher#do_validation'
    return true if self.ok
    update_validation
    self.ok
  end
  
  def update_validation
    ap 'CommonWorkIpiPublisher#update_validation'
    set_ok
  end
  
  
  def error_message
    ap 'CommonWorkIpiPublisher#error_message'
    em = {}
    
    if publisher = self.publisher
      if publishing_agreement = self.publishing_agreement
        if document = publishing_agreement.document
          unless document.signed?
            em[:publishing_agreement_document]  = message_hash(self, 'Publishing agreement is not signed')
          end
        else
          em[:publishing_agreement_document]  = message_hash(self, 'Publishing has no documents')
        end
      else
        em[:publishing_agreement] = message_hash(self, 'Publishing agreement is missing')
      end
    else
      em[:publisher] = message_hash(self, 'Not connected to a publisher')
    end
   
    em
  end
  
  after_commit :flush_cache

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

  private 

    def set_ok
      ap 'CommonWorkIpiPublisher#set_ok'
      em = error_message
      
      if self.user
        update_columns( ok: em.empty? ) 
        self.ok ? remove_notification_message(self, self.user_id) : 
          update_notification_message(self, self.user_id).update_columns(
            error_message: em
          )
        flush_cache
      end
    end
    


    def flush_cache
      Rails.cache.delete([self.class.name, id])
    end
  
end
