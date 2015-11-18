class Api::MandrillHookController < ApplicationController
  include Mandrill::Rails::WebHookProcessor
  
  # ------------- DO THIS ------------------------
  authenticate_with_mandrill_keys! Rails.application.secrets.webhook_key
  
  ignore_unhandled_events!
  
  def create
    begin
      Rails.logger.info '======================================================='
      Rails.logger.info params
    rescue
      Rails.logger.info "Api::MandrillHookController / create"
    end
  end
  
  def handle_inbound(event)
    # 'event_payload'
    # event
  end
  
  def handle_send(event)
    ##'handle sent'
    if message = get_by_id( event )
      message.delivered!
    end

  end
  
  def get_by_id event
    # event["tags"]
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
    
    # '--- handle handle_clicks_and_opens  ----'
    if message = get_by_id( event )

      if msg = event["msg"]
        if opens =  msg["opens"]
          message.opens   = opens.count
        end
        if open =  msg["open"]
          message.opens   = message.opens.to_i + 1
        end
        if clicks = msg["clicks"]
          message.clicks = clicks.count
        end
        message.save

      end
    end
  end
  

    
end
