# https://www.railstutorial.org/book/following_users
class RelationshipsController < ApplicationController
  # convert to Ajax
  def create
    @user = User.find(params[:relationship][:followed_id])
    relationship = current_user.follow!(@user)
    
    
    current_user.create_activity(  :created, 
                               owner: relationship,
                           recipient: @user,
                      recipient_type: 'Relationship',
                          account_id: current_user.account_id) 
                          
                          
                          
    #redirect_to :back
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    #redirect_to :back
  end
end