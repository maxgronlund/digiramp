class ActivitiesController < ApplicationController
  
  
   
  def index
    
    if @user = User.friendly.find(params[:user_id])
      
      if current_user && @user != current_user
        @user.views += 1 
        @user.save
      end
    
      @user.create_activity(  :show, 
                                owner: current_user,
                            recipient: @user,
                       recipient_type: @user.class.name,
                           account_id: @user.account_id)
    
      session[:account_id] = @user.account_id 
    
      if current_user 
        if current_user.current_account_id != current_user.account.id
          current_user.current_account_id  = current_user.account.id
          current_user.save!
        end
        @playlists  = current_user.playlists
        
        if current_user.id == @user.id || current_user.super?
          @authorized = true
        else
          @authorized = false
        end
      end
      
      
      
    else
      not_found
    end
    
    
  end
end
