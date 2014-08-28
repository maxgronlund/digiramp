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
    get_lovers_id
    render nothing: true
  end
  
  def get_lovers_id
    begin
      puts 'try request.remote_ip'
      ap request.remote_ip
    rescue
      puts 'error on request.remote_ip'
    end
    begin
      puts 'try request.remote_ip'
      ap request.env["HTTP_X_FORWARDED_FOR"]
    rescue
      puts 'error on  request.env["HTTP_X_FORWARDED_FOR"]'
    end
  end

end
