class User::ContactInvitationsController < ApplicationController
  def show
    @contact = Client.cached_find(params[:id])
    @user = User.cached_find(params[:user_id])
    @client_invitation = ClientInvitation.where(account_id: @user.account_id, client_id: params[:id])
                                         .first_or_create( account_id: @user.account_id, 
                                                           client_id:  params[:id],
                                                           user_id:    @user.id,
                                                           status:     'invited',
                                                           uuid:       UUIDTools::UUID.timestamp_create().to_s )

  end
  
end
