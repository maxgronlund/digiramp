class Api::MandrillHookController < ApplicationController
  include Mandrill::Rails::WebHookProcessor
  
  # ------------- DO THIS ------------------------
  authenticate_with_mandrill_keys! Rails.application.secrets.webhook_key
  
  ignore_unhandled_events!
  
  def handle_inbound(event)
    ap 'event_payload'
    ap event
  end
  
  def handle_send(event)
    #ap 'handle sent'
    if message = get_by_id( event )
      message.delivered!
    end

  end
  
  def get_by_id event
    #ap event["tags"]
    if _id = event["_id"]
      return ClientInvitation.find_by(mandrill_id: _id)
    end
  end
  
  def handle_open event
    #'---- handle open ----'
    handle_clicks_and_opens event
  end
  
  def handle_click event
    #'--- handle click ----'
    handle_clicks_and_opens event
  end
  
  def handle_clicks_and_opens event
    
    '--- handle handle_clicks_and_opens  ----'
    if message = get_by_id( event )
      ap message
      if msg = event["msg"]
        if opens =  msg["opens"]
          message.opens   = opens.count
        end
        if clicks = msg["clicks"]
          message.clicks = clicks.count
        end
        message.save
        ap message
      end
    end
  end
  
  #def handle_hard_bounce(event)
  #  message = get_message_from( event ) and message.hard_bounce!
  #end
  #
  #def handle_soft_bounce(event)
  #  message = get_message_from( event ) and message.soft_bounce!
  #end
  #
  #def handle_spam(event)
  #  message = get_message_from( event ) and message.spam!
  #end
  #
  #def handle_reject(event)
  #  message = get_message_from( event ) and message.reject!
  #end
  #
  #def handle_unsub(event)
  #  message = get_message_from( event ) and message.unsub!
  #end
  

  #def get_message_from event
  #  if metadata = get_metadata( event )
  #    ap '-- metadata --'
  #    if message_id = metadata["message_id"]
  #      return Message.find_by(id: message_id)
  #    elsif invitation_id = metadata["invitation_id"]
  #      return ClientInvitation.find_by(id: invitation_id)
  #    end
  #  end
  #  nil
  #end
  #
  #def get_metadata event
  #  if msg = event["msg"]
  #    ap '-- msg --'
  #    ap msg
  #    return msg["metadata"]
  #  end
  #  nil
  #end
  
  #def create
  #  ap params
  #  render nothing: true
  #end
  #
  #def show
  #  ap params
  #  render nothing: true
  #end
 
    
end
