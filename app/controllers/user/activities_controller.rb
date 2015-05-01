class User::ActivitiesController < ApplicationController
  before_action :access_user
  
  def index

    #if @user = User.friendly.find(params[:user_id])
    @wall_posts          = @user.wall_posts.where.not(user_id: @user.id).order('created_at desc').page(params[:page]).per(4)
    @playlists           = current_user.playlists
    #user_ids             =  User.public_profiles.where(featured: true).order('featured_date desc').first(16).pluck(:id) 
    user_ids             = User.public_profiles.where(featured: true).pluck(:id).first(32)
    if current_user
      followed_ids         = current_user.followed_users.public_profiles.pluck(:id)
      @users               = User.where(id: user_ids - followed_ids).first(16)
    else
      @users               = User.where(id: user_ids).first(16)
    end
    #session[:account_id] = @user.account_id 
    
    #if current_user 
    #  if current_user.current_account_id != current_user.account.id
    #    current_user.current_account_id  = current_user.account.id
    #    current_user.save!
    #  end
    #  @playlists  = current_user.playlists
    #end
      
      #@connections = Connection.where("user_id = ?  OR  connection_id = ?" , @user.id, @user.id).order('created_at desc').page(params[:page]).per(8)
      
    #else
    #  not_found
    #end
  end
  
  
  #def index
  #  #@activities = PublicActivity::Activity.where(owner_id: @user.id).order('created_at desc').page(params[:page]).per(36)
  #end
end
