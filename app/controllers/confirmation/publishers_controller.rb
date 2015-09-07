class Confirmation::PublishersController < ApplicationController
  
  def show
    @publisher = Publisher.find_by!(transfer_uuid: params[:id])
    if @user = current_user
       
    else
      redirect_to login_new_path
      session[:current_page] = confirmation_publisher_path(params[:id])
    end
    
  end
  
  def edit
    ap '----------------------------------------------------------------'
    ap 'Confirmation::PublishersController#edit'
    @publisher = Publisher.find_by!(transfer_uuid: params[:id])
    
    if current_user && current_user.has_email( @publisher.email )
      @user       = current_user
      @publishers = nil
      if account = current_user.account
        ap 'we got an account'
        @publishers = account.publishers
        
        unless @publishers.empty? 
          ap '--------- hey there is publishers here -------------------'
          ap @publishers
        else
          grab_publisher
          flash[:info] = 'Please confirm/edit legal informations.'
          redirect_to edit_user_user_publisher_legal_info_path(@user, @publisher)
        end
      else
        ' oh snap how can I end here'
      end
       
    else
      ap 'forbidden'
      forbidden
    end
  end
  
  def grab_publisher
    #ap '--------- Ok Im grapping this one -------------------'
    @publisher.i_am_my_own_publisher = true
    @publisher.user_id               = @user.id
    @publisher.account_id            = current_user.account.id
    @publisher.confirmed!
    @user.copy_address_to( @publisher.address )
    @publisher.save
    UserPublisher.where(user_id: @publisher.user_id, publisher_id: @publisher.id)
                 .first_or_create(user_id: @publisher.user_id, publisher_id: @publisher.id)
  end

  def update
    @publisher = Publisher.find_by!(transfer_uuid: params[:id])
    redirect_to :back
  end
  
  def destroy
    @publisher = Publisher.find_by!(transfer_uuid: params[:id])
    
    if current_user.has_email( @publisher.email )
      @publisher.declined!
      redirect_to user_user_control_panel_index_path(current_user)
    else
      forbidden
    end
  end
end
