class User::ConfirmCommonWorkIpisController < ApplicationController
  before_action :access_user, only: [:update]
  
  # when a user receives a common_work_ipi email there is a link the this
  # function
  #
  # If the user is not logged in the user will be taken to the login screen
  def edit
    if @common_work_ipi = CommonWorkIpi.find_by(uuid: params[:id])
      if current_user && @common_work_ipi.user.permits?(current_user) 
        @user = @common_work_ipi.user
        @common_work = @common_work_ipi.common_work
        #@common_work_ipi.accepted!
      elsif current_user
        forbidden
      else
        session[:request_url] =  edit_user_user_confirm_common_work_ipi_path(@common_work_ipi.user, @common_work_ipi.uuid)
        redirect_to login_new_path
      end
    else
      not_found
    end
  end

  def update
    @common_work_ipi = CommonWorkIpi.find_by(uuid: params[:id])
    @common_work_ipi.confirmed!
    destroy_user_notification
    redirect_to :back
  end
  
  
  
  private
    
    
    def destroy_user_notification
    
      if user_notification = UserNotification.find_by( 
          user_id:    @common_work_ipi.user_id,
          asset_type: @common_work_ipi.class.name,
          asset_id:   @common_work_ipi.id,
          status:     'notice',
          message:    'Confirm role'
        )
        user_notification.destroy
      end
    end
    
    
    
  
end
