class User::InviteClientGroupsController < ApplicationController
  def update
    client_group = ClientGroup.find(params[:id])
    client_group.invited = true
    client_group.save!

  end
end
