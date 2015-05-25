class Api::SendgridHookController < ApplicationController
  protect_from_forgery except: [:update]
  def update
    #ap request.content_type
    params.each do |p|
      
      p.each do | params|
        #ap params.class.name
        if params.class.name == "ActionController::Parameters"
          params["_json"].to_a.each do |event|
            Rails.logger.info '===================================================================================='
            Rails.logger.info event
            Rails.logger.info '===================================================================================='
            case event["event"]
            when "processed"    
              processed event
            when "dropped"      
              dropped event
            when "delivered"    
              delivered event
            when "open"         
              open event
            when "click"        
              click event
            when "bounce"       
              bounce event
            when "unsubscribe"  
              unsubscribe event
            end
          end
        end
      end
    end
  end
  
  
  def processed event
    if client_invitation = ClientInvitation.pending.where(email: event["email"]).last
      client_invitation.processed!
      Rails.logger.info '---------------------- found and processed --------------------------'
      Rails.logger.info client_invitation
    end
  end
  
  def dropped event
    if client_invitation = ClientInvitation.pending.where(email: event["email"]).last
      client_invitation.dropped!
      client_invitation.sendgrid_msg = event["reason"]
      client_invitation.save
    end
  end
  
  def delivered event
    if client_invitation = ClientInvitation.processed.where(email: event["email"]).last
      client_invitation.delivered!
      Rails.logger.info '---------------------- found and delivered --------------------------'
      Rails.logger.info client_invitation
    end
    
  end
  
  def open event
    if client_invitation = ClientInvitation.delivered.where(email: event["email"]).last
      client_invitation.opened!
      Rails.logger.info '---------------------- found and opened --------------------------'
      Rails.logger.info client_invitation
    end
  end
  
  def click event
    if client_invitation = ClientInvitation.opened.where(email: event["email"]).last
      client_invitation.clicked!
      Rails.logger.info '---------------------- found and clicked --------------------------'
      Rails.logger.info client_invitation
    end
  end
  
  def bounce event
    if client_invitation = ClientInvitation.processed.where(email: event["email"]).last
      client_invitation.bounced!
      client_invitation.sendgrid_msg = event["reason"]
      client_invitation.save
    end
  end
  
  def unsubscribe event
    if client_invitation = ClientInvitation.where(email: event["email"], sendgrid_status: 'processed').last
      client_invitation.unsubscribed!
    end
  end
end
