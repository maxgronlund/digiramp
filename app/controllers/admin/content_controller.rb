class Admin::ContentController < ApplicationController
  before_filter :admins_only

  def index
    @user = current_user
    @authorized = true
  end
end