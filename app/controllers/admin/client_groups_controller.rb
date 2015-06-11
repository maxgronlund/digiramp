class Admin::ClientGroupsController < ApplicationController
  
  before_action :admin_only
  


  def index
    @client_groups = ClientGroup.order(:id).page(params[:page]).per(50)
  end

  def show
     @client_group  = ClientGroup.cached_find(params[:id])
  end
  
 
  def update
    begin
      @clint_group = ClientGroup.cached_find(params[:id])
      #remove_invitations_from @clint_group
      count = @clint_group.invitation_count 
      @clint_group.invitation_count = count + 1
      @clint_group.invited          = true
      @clint_group.save!
      @clint_group.invite_clients
    rescue
      ap 'not found'
      Opbeat.capture_message("ClientGroupsController: unable to resend invitations")
    end
    #ClientInvitationMailer.delay.invite_all_from_group( params[:id])
    #@clint_group.update(client_group_params)
    redirect_to admin_client_groups_path
  end
  
  def remove_invitations_from client_group
    if client_ids          = client_group.clients.pluck(:id)
      if client_invitations = ClientInvitation.where( client_id: client_ids )
        client_invitations.destroy_all
      end
    end
  end

  def edit
    @contact_group = ClientGroup.cached_find(params[:id])
  end

  #def destroy
  #  contact_group  = ClientGroup.cached_find(params[:id])
  #  @contact_group_id  = contact_group.id
  #  contact_group.destroy
  #end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def client_group_params
    params.require(:client_group).permit!
  end
  
 
  
end
