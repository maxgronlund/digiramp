class Confirmation::IpiConfirmationsController < ApplicationController
  
  def show
    # login or signup
    redirect_to confirmation_login_user_path(uuid: params[:id]) if current_user.nil?
  
    return not_found unless @ipi    = Ipi.find_by(uuid: params[:id])
    return not_found unless @user   = User.get_by_email( @ipi.email )
    

    if current_user.id != @user.id
      #there is a IPI and a user but the user 
      redirect_to confirmation_wrong_user_path(uuid: params[:id])
    end
    
    
    
    # validate data integrity
    not_found( params )  unless ( @common_work = @ipi.common_work ) && 
                                ( account = @common_work.account ) && 
                                ( @requester = account.user )
    
    
    redirect_to user_user_ipi_path(@user, @ipi ) 
    
  end

  #def edit
  #end
  #
  #def update
  #  @ipi              = Ipi.where(uuid: params[:id]).first
  #  @user             = User.get_by_email( @ipi.email )
  #  @ipi.user_id      = @user.id
  #  @ipi.confirmation = 'Confirmed'
  #  @ipi.save!
  #  
  #  redirect_to user_user_ipi_path( @user, @ipi)
  #  
  #end
  #
  #private
  #
  #def check_if_email_is_linked_to_useer
  #  
  #  
  #end
end
