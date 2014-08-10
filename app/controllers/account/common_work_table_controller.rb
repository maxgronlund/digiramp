class Account::RecordingsBucketController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
  include AccountsHelper
  before_filter :access_account
  

  
  
  def update
    common_work = CommonWork.cached_find(params[:id])
    common_work.update_attributes(common_work_params)
    
    common_work.create_activity(  :updated, 
                              owner: current_user,
                          recipient: common_work,
                     recipient_type: common_work.class.name,
                         account_id: @account.id)
                         
                         
    render nothing: true
  end

  
private
  

  
  def common_work_params
    params.require(:common_work).permit!
  end

end
