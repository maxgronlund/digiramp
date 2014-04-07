class Admin::UserMoodsController < ApplicationController
  before_filter :admin_only
  def index
    @moods = Mood.user_tags.order('lower(title) ASC').page(params[:page]).per(32)
  end
end
