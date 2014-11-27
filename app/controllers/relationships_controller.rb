# https://www.railstutorial.org/book/following_users
class RelationshipsController < ApplicationController
  # convert to Ajax
  def create
    @user = User.find(params[:relationship][:followed_id])
    relationship = current_user.follow!(@user)
    
    @user.followers_count += 1
    @user.save
    
    #current_user.create_activity(  :created, 
    #                           owner: relationship,
    #                       recipient: @user,
    #                  recipient_type: 'Relationship',
    #                      account_id: current_user.account_id) 
    #                      
    #                      
    @remove_button    = "#follow_user_#{@user.id.to_s}"  
    @add_button       = "#follow_unfollow_#{@user.id.to_s}"        
    
    Activity.notify_followers( 'is following', current_user.id, 'User' , relationship.followed_id )            

  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    
    @user.followers_count -= 1
    @user.save
    
    current_user.unfollow!(@user)
    @remove_button    = "#unfollow_user_#{@user.id.to_s}"
    @add_button       = "#follow_unfollow_#{@user.id.to_s}"  
  end
end