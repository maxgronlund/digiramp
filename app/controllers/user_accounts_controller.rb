class UserAccountsController < ApplicationController
  def index
    begin
      @user = User.cached_find(params[:user_id])
    rescue
       @user = User.cached_find(params[:id])
    end
  end
end
