class Api::SendgridHookController < ApplicationController
  protect_from_forgery except: [:update]
  def update
    #ap request.content_type
    params.each do |p|
      
      p.each do | params|
        #ap params.class.name
        if params.class.name == "ActionController::Parameters"
          params["_json"].to_a.each do |event|
            ap event
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
    ap '-- processed --'
    ap event["email"]
    if client_invitations = ClientInvitation.where(email: event["email"], status: :pending)
      ap client_invitations
      client_invitations.update_all(status: :processed)
    end
  end
  
  def dropped event
    ap '-- dropped --'
    ap event["email"]
    ap event["reason"]
  end
  
  def delivered event
    ap '-- delivered --'
    ap event["email"]
    
  end
  
  def open event
    ap '-- open --'
    ap event["email"]
    
  end
  
  def click event
    ap '-- click --'
    ap event["email"]
    
  end
  
  def bounce event
    ap '-- bounce --'
    ap event["email"]
    
    ap event["reason"]
  end
  
  def unsubscribe event
    ap '-- unsubscribe --'
    ap event["email"]
    
    
  end
end
