class Admin::ActivitiesController < ApplicationController
  before_action :admin_only
  def index
    @activities = PublicActivity::Activity.order('created_at desc').page(params[:page]).per(36)
  end
end
