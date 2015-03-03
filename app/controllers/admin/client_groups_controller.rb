class Admin::ClientGroupsController < ApplicationController
  
  before_filter :admin_only
  


  def index
    @client_groups = ClientGroup.order(:id).page(params[:page]).per(50)
  end

  def show
     @client_group  = ClientGroup.cached_find(params[:id])
  end
  
 
  def update

    @clint_group = ClientGroup.cached_find(params[:id])
    @clint_group.invitation_count += 1
    @clint_group.invited = true
    @clint_group.save!
    #ClientInvitationMailer.delay.invite_all_from_group( params[:id])
    #@clint_group.update(client_group_params)
    redirect_to admin_client_groups_path
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
