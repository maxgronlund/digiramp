class User::AccountsController < ApplicationController
  before_action :access_user
  def index
    @account_users = AccountUser.where(user_id: @user.id)
  end
end
