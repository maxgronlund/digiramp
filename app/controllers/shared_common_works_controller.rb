class SharedCommonWorksController < ApplicationController
  
  include SharedCommonWorksHelper
  
  before_filter :access_user
  before_filter :read_common_work, only:[:show]
  before_filter :update_common_work, only:[:edit, :update]
  
  
  def show
  end

  def index
  end
  
  def edit
    
  end
  
  def update
    @account.works_cache_key += 1
    @account.save
    if @common_work.update_attributes(common_work_params)
      @common_work.update_completeness
      redirect_to user_shared_catalog_shared_recording_shared_common_work_path(@user, @catalog, @recording, @common_work)
    else
      redirect_to edit_user_shared_catalog_shared_recording_shared_common_work_path(@user, @catalog, @recording, @common_work)
    end
  end
  
private

  def common_work_params
    params.require(:common_work).permit!
  end
    
    
end
