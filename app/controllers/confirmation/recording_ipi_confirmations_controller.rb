class Confirmation::RecordingIpiConfirmationsController < ApplicationController
  def show
    if @recording_ipi    = RecordingIpi.where(uuid: params[:id]).first
      @user   = User.get_by_email( @recording_ipi.email )
    end
    
    ##@user
    
    # things that can happen if the ipi the current_user ore the user is missing
    if current_user.nil?
      # login or signup
    elsif @recording_ipi.nil?
      # there is a current_user but IPI is not found
      redirect_to confirmation_ipi_not_found_index_path
    
    elsif @user.nil?
      # there is a current_user but the user for the ipi is not found
      redirect_to confirmation_user_not_found_index_path( uuid: params[:id])
      
    #elsif @ipi.nil?
    #  # there is no current_user and no IPI
    #  redirect_to confirmation_invalid_ipis_path
    #
    #elsif @user.nil?
    #  #there is a IPI but no user for the ipi
    #  redirect_to new_confirmation_user_path(uuid: params[:id])
    
    
    # there is user and a current user and a ipi
    # the current user don't have the user email on his account
    elsif current_user.id != @user.id
      #there is a IPI and a user but the user 
      redirect_to confirmation_wrong_recording_user_path(uuid: params[:id])
    else
      return not_found( params )  unless ( @recording = @recording_ipi.recording ) && ( account = @recording.account ) && ( @requester = account.user )
      redirect_to user_user_recording_ipi_path(@user, @recording_ipi ) if  @recording_ipi.confirmed?
    end

  end

  def edit
  end

  def update
    @recording_ipi              = RecordingIpi.where(uuid: params[:id]).first
    @user                       = User.get_by_email( @recording_ipi.email )
    @recording_ipi.user_id      = @user.id
    @recording_ipi.save!
    @recording_ipi.confirmed!
    redirect_to user_user_recording_ipi_path( @user, @recording_ipi)
    
  end
  
  private
  
  def check_if_email_is_linked_to_useer
    
    
  end
end
