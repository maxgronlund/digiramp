class UserRecordingsController < ApplicationController
  before_filter :access_user
  def index
    # all catalogs where the user is graned permission
    catalog_ids       =  CatalogUser.where(user_id: @user.id).pluck(:catalog_id)
    
    # all recordings from catalogs shared with the user
    recording_ids     =  CatalogItem.where(catalog_id: catalog_ids, catalog_itemable_type: 'Recording').pluck(:catalog_itemable_id)
    
    # all recordings from the users account
    recording_ids     += @user.account.recordings
    
    # pull rcordings
    @recordings       =  Recording.where(id: recording_ids)

    # find recordings
    @recordings       =  Recording.not_in_bucket.catalogs_search(@recordings, params[:query]).order('title asc').page(params[:page]).per(56)
    

  end
  
  def show
    @recording = Recording.cached_find(params[:id])
  end
  
  def edit
    @recording = Recording.cached_find(params[:id])
  end
  
  def update
    @recording = Recording.cached_find(params[:id])
    @recording.update_attributes(recording_params)
    redirect_to user_user_recording_path( @user, @recording)
  end
  
  def destroy
    @recording = Recording.cached_find(params[:id])
    @recording.destroy!
    redirect_to user_user_recordings_path( @user)
  end
  
private

  def recording_params
    params.require(:recording).permit!
  end

end
