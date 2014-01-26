class MessageWorker
  include Sidekiq::Worker
  
  def perform options={}
    #Whoa! You can't use symbols in the hash
    #Beware!
    options['type']   ||= 'info'
    options['time']   ||= 5000
    options['sticky'] ||= false
    if options['notification_event_id'].to_i != 0
      return unless NotificationEvent.exists? options['notification_event_id'].to_i
    end
    PrivatePub.publish_to options['channel'],
                          title:  options['title'].to_s, 
                          body:   options['body'].to_s, 
                          type:   options['type'],
                          time:   options['time'],
                          sticky: options['sticky'],
                          id:     options['id'],
                          notification_event_id: options['notification_event_id']
  end
end