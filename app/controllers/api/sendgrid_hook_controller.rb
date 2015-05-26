class Api::SendgridHookController < ApplicationController
  protect_from_forgery except: [:update]
  def update

    params.each do |p|
      
      p.each do | params|
        #ap params.class.name
        if params.class.name == "ActionController::Parameters"
          params["_json"].to_a.each do |event|
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
    if client_invitation = ClientInvitation.find_by(id: event["uniq_ids"].to_i)
      client_invitation.processed!
    end
  end
  
  def dropped event
    if client_invitation = ClientInvitation.find_by(id: event["uniq_ids"].to_i)
      client_invitation.dropped!
      client_invitation.sendgrid_msg = event["reason"]
      client_invitation.save
    end
  end
  
  def delivered event
    if client_invitation = ClientInvitation.find_by(id: event["uniq_ids"].to_i)
      client_invitation.delivered!
    end  
  end
  
  def open event
    if client_invitation = ClientInvitation.find_by(id: event["uniq_ids"].to_i)
      client_invitation.opened!
    end
  end
  
  def click event
    if client_invitation = ClientInvitation.find_by(id: event["uniq_ids"].to_i)
      client_invitation.clicked!
    end
  end
  
  def bounce event
    if client_invitation = ClientInvitation.find_by(id: event["uniq_ids"].to_i)
      client_invitation.bounced!
      client_invitation.sendgrid_msg = event["reason"]
      client_invitation.save
    end
  end
  
  def unsubscribe event
    if client_invitation = ClientInvitation.find_by(id: event["uniq_ids"].to_i)
      client_invitation.unsubscribed!
    end
  end
end
