class ActivitiesController < ApplicationController
  
  
   
  def index
    
    #if @user = User.friendly.find(params[:user_id])
    #  @wall_posts = @user.wall_posts.where.not(user_id: @user.id).order('created_at desc').page(params[:page]).per(4)
    #
    #  session[:account_id] = @user.account_id 
    #  
    #  if current_user 
    #    if current_user.current_account_id != current_user.account.id
    #      current_user.current_account_id  = current_user.account.id
    #      current_user.save!
    #    end
    #    @playlists  = current_user.playlists
    #  end
    #  
    #  #@connections = Connection.where("user_id = ?  OR  connection_id = ?" , @user.id, @user.id).order('created_at desc').page(params[:page]).per(8)
    #  
    #else
    #  not_found
    #end
  end
end
