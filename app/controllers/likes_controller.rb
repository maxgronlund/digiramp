class LikesController < ApplicationController
  before_filter :get_user
  def index
    @likes = Like.order('created_at desc').where(user_id: @user.id)
    
    
  end
  
  def new
    
    #user = User.friendly.find(params[:user_id])
    
    like = Like.where(
                        user_id: @user.id,
                        recording_id: params[:recording_id],
                        )
                .first_or_create(
                        user_id: @user.id,
                        recording_id: params[:recording_id],
                        account_id: @user.account_id
                        )
    recording = Recording.cached_find(params[:recording_id])
    
    @user.create_activity(   :created, 
                               owner: like, 
                           recipient: recording,
                      recipient_type: 'Recording',
                          account_id: recording.account_id) 
                          
                          
    render nothing: true
    #@like = 'like_' + like.id.to_s
  end
  
  def show
    
  end
  
  def destroy
    user = User.friendly.find(params[:user_id])
    like = Like.where(user_id: user.id, recording_id: params[:id]).first          
    like.destroy 
    render nothing: true
  end
end



#create_table "likes", force: true do |t|
#  t.integer  "user_id"
#  t.integer  "recording_id"
#  t.integer  "account_id"
#  t.datetime "created_at"
#  t.datetime "updated_at"
#end
