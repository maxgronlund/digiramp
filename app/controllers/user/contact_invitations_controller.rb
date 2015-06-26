class User::ContactInvitationsController < ApplicationController
  def show
    @client = Client.cached_find(params[:id])
    @user   = User.cached_find(params[:user_id])
    @client_invitation = ClientInvitation.where(account_id: @user.account.id, client_id: params[:id])
                                         .first_or_create( account_id: @user.account.id, 
                                                           client_id:  params[:id],
                                                           user_id:    @user.id,
                                                           uuid:       UUIDTools::UUID.timestamp_create().to_s,
                                                           email:      @client.email )
    @client_invitation.send_one_with_avatar

  end
  
end
