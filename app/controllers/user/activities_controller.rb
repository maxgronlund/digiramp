class User::ActivitiesController < ApplicationController
  before_filter :access_user, only: [:index]
  def index
    #@activities = PublicActivity::Activity.where(owner_id: @user.id).order('created_at desc').page(params[:page]).per(36)
  end
end
