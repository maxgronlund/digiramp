class User::ConfirmCommonWorkIpisController < ApplicationController
  before_action :access_user, only: [:update, :destroy]
  
  # when a user receives a common_work_ipi email there is a link the this
  # function
  #
  # If the user is not logged in login
  # If the user is not confirmed go the the Confirmation#edit 
  def edit
    
    not_found unless @common_work_ipi = CommonWorkIpi.find_by(uuid: params[:id]) 
    not_found unless @user            = User.cached_find(params[:user_id])
    not_found unless @common_work     = @common_work_ipi.common_work

    # the user is logged in all is ok
    # go to the real confirmation sreen for logged in users
    if super? || (current_user && current_user == @user)
      edit_user_user_confirm_common_work_ipi_path(current_user, @common_work_ipi.uuid)
    
    # The user exists but is not logged in
    elsif invited_user = User.get_by_email(@user.email)
      
      session[:request_url] =  edit_user_user_confirm_common_work_ipi_path(@common_work_ipi.user, @common_work_ipi.uuid)
      # if the user is not confirmed go the the confirmation screen for new creators
      if invited_user.account_activated
        #redirect_to confirmation_creator_edit_path(uuid: @common_work_ipi.uuid)
      # go to the login path
      redirect_to login_new_path
      else
        redirect_to edit_confirmation_creator_path(@user.password_reset_token, uuid: @common_work_ipi.uuid)
      end
    end

   
  end

  def update
    @common_work_ipi = CommonWorkIpi.find_by(uuid: params[:id])
    @common_work_ipi.confirmed!
    @common_work_ipi.update( ipi_id: @user.ipi.id )
    
    if common_work     = @common_work_ipi.common_work
      common_work_user = CommonWorkUser.where(
        common_work_id:           common_work.id,
        user_id:                  @common_work_ipi.user_id
      )
      .first_or_create(
        common_work_title:        common_work.title,
        common_work_id:           common_work.id,
        user_id:                  @common_work_ipi.user_id,
        can_manage_common_work:   @common_work_ipi.can_edit_common_work
      )
      @common_work_ipi.update_validation
      
    end
    
    redirect_to :back
  end
  
  def destroy
    @common_work_ipi = CommonWorkIpi.find_by(uuid: params[:id])
    @common_work_ipi.destroy
    redirect_to user_path(@user)
  end
  
  
  
  private
    def publisher_id
      publisher_id = nil
      if publisher = @user.get_publisher
        publisher_id = publisher.id
      end
      publisher_id
    end
    
    
    
    
    
  
end
