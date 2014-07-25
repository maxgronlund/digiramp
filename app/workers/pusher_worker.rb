class PusherWorker
  include Sidekiq::Worker
  
  def perform options={}
    
    ap options
    
    Pusher.trigger(options['channel'], 'digiramp_event', 
                                          {"title"  => options['title'].to_s, 
                                          "message" => options["message"].to_s, 
                                          "time"    => options['time'],
                                          "sticky"  => options['sticky'],
                                          "image"   => options['image'],
                                          })
  end
end