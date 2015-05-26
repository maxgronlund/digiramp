class User::InviteClientGroupsController < ApplicationController
  before_action :access_user
  
  def update

    @client_group = ClientGroup.find(params[:id])
    @client_group.invited = true
    @client_group.save!
    @client_group.invite_clients
    flash[:info] = "Processing invitations: reload this page to se how many emails was delivered, opened and clicked on" 
    redirect_to user_user_contact_group_path(@user, @client_group)

  end
end
