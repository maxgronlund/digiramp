class Admin::NudgeController < ApplicationController
  
  
  def invite_friend
    NudgeMailer.delay.invite_friends
    redirect_to :back
  end

  def share_recordings
  end

  def connect_to_users
  end

  def write_comments
  end

  def like_recordings
  end
end
