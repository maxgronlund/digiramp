class Confirmation::IpiConfirmationsController < ApplicationController
  def show
   
    @ipi    = Ipi.where(uuid: params[:id]).first
    @user   = User.get_by_email( @ipi.email )
    
    # things that can happen if the ipi the current_user ore the user is missing
    if current_user.nil?
      # login or signup
    elsif @ipi.nil?
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
      redirect_to confirmation_wrong_user_path(uuid: params[:id])
    end
    
    redirect_to user_user_ipi_path(@user, @ipi ) if  @ipi.confirmation == "Confirmed"
    
    not_found( params )  unless ( @common_work = @ipi.common_work ) && ( account = @common_work.account ) && ( @requester = account.user )
    
    
    
    
  end

  def edit
  end

  def update
    @ipi              = Ipi.where(uuid: params[:id]).first
    @user             = User.get_by_email( @ipi.email )
    @ipi.user_id      = @user.id
    @ipi.confirmation = 'Confirmed'
    @ipi.save!
    
    redirect_to user_user_ipi_path( @user, @ipi)
    
  end
  
  private
  
  def check_if_email_is_linked_to_useer
    
    
  end
end
