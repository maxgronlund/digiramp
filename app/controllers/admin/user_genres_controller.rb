class Admin::UserGenresController < ApplicationController
  before_filter :admin_only
  def index
    #@genres = Genre.where(user_tag: true).order('lower(title) ASC').page(params[:page]).per(32)
    @genres = Genre.where(user_tag: true).search(params[:query]).order('lower(title) ASC').page(params[:page]).per(32)
  end
end
