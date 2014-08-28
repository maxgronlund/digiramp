class Digiwham::LikesController < ApplicationController

  # count likes
  def show
    recording               = Recording.cached_find(params[:id])
    recording.likes_count   += 1
    recording.save!
    user_id                 = current_user ? current_user.id : nil
    Like.where( recording_id: recording.id, 
                user_id: user_id, 
                account_id: recording.account_id 
              ).first_or_create(
                recording_id: recording.id, 
                user_id: user_id, 
                account_id: recording.account_id 
              )
    get_ip_address
    render nothing: true
  end
  
  def get_lovers_id
    ap request.remote_ip
    ap request.env["HTTP_X_FORWARDED_FOR"]
  end

end
