class User::CreativeRightsController < ApplicationController
  
  
  before_filter :access_user
  
  
  def index

    @common_works = CommonWork.account_search(@user.account, params[:query] ).order('title desc').page(params[:page]).per(48)

  end

  def show
    @recording   = Recording.cached_find(params[:recording_id])
    @common_work = @recording.common_work
  end

  def edit
  end

  def update
  end
  
  def destroy
    common_work = CommonWork.cached_find(params[:id])
    common_work.destroy!
    redirect_to user_user_creative_rights_path(@user)
   
  end
end
