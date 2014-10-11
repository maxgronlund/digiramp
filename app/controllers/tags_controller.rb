class TagsController < ApplicationController
  #include AccountsHelper
  #before_filter :access_account
  def edit
    #@common_work = CommonWork.cached_find(params[:common_work_id])
    @user         = User.friendly.find(params[:user_id])
    @recording    = Recording.cached_find(params[:id])
  end
  
  def update
    @user                   = User.friendly.find(params[:user_id])
    @recording              = Recording.cached_find(params[:id])
    @recording.mood         = params[:recording][:mood]
    @recording.genre        = params[:recording][:genre]
    @recording.instruments  = params[:recording][:instruments]
    @recording.extract_genres
    @recording.extract_instruments
    @recording.extract_moods
    @recording.save
    @authorized             = true
  end
  

end
