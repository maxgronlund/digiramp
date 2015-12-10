class Admin::FakeUsersController < ApplicationController

  before_action :admin_only
  before_action :set_user, only: [:show, :update, :destroy]
  
  def index
    #@users = User.where( "created_at < ?", Time.now - 24.hours ).where(confirmed_at: nil).page(params[:page]).per(100)
    #@users = User.where( "completeness < ?", 10 ).page(params[:page]).per(100)
    @users = User.order("id desc").where( completeness: 0 ).page(params[:page]).where( "created_at < ?", Time.now - 24.hours ).per(100)
  end
end
