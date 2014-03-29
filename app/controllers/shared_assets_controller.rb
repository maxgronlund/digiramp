class SharedAssetsController < ApplicationController
  def index
    access = false
    begin 
      @user = User.cached_find(params[:user_id])
    rescue
      forbidden
    end
    if current_user && current_user.can_edit?
      access = true
    elsif current_user && current_user.id == @user.id
      access = true 
    end
    forbidden unless access
  end
end
