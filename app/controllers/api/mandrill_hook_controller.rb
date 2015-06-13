class Api::MandrillHookController < ApplicationController
  include Mandrill::Rails::WebHookProcessor
  
  # ------------- DO THIS ------------------------
  authenticate_with_mandrill_keys! Rails.application.secrets.webhook_key
  
  ignore_unhandled_events!
  
  def handle_inbound(event)
    'event_payload'
    ap event
  end
  
  def handle_send(event)
    message = get_message_from( event ) and message.sent!
  end
  
  def handle_open(event)
    message = get_message_from( event ) and message.opened!
  end
  
  def handle_click(event)
    message = get_message_from( event ) and message.clicked!
  end
  
  def handle_hard_bounce(event)
    message = get_message_from( event ) and message.hard_bounce!
  end
  
  def handle_soft_bounce(event)
    message = get_message_from( event ) and message.soft_bounce!
  end
  
  def handle_spam(event)
    message = get_message_from( event ) and message.spam!
  end
  
  def handle_reject(event)
    message = get_message_from( event ) and message.reject!
  end
  
  def handle_unsub(event)
    message = get_message_from( event ) and message.unsub!
  end
  
  def get_message_from event
    if msg = event["msg"]
      if metadata = msg["metadata"]
        if message_id = metadata["message_id"]
          return Message.find(message_id)
        end
      end
    end
    nil
  end
  
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
