class User::AddContactsController < ApplicationController
  
  before_action :access_user
  
  
  def index
    # make sure select all is turned off bu default
    session[:select_all_recordings]  = false unless params[:page]

    @contact_group          = ClientGroup.cached_find(params[:contact_group_id])
    @account                = @user.account
    
    #!!! optimize this
    contact_in_group_ids    = ClientGroupsClients.where(client_group_id: @contact_group.id).pluck(:client_id)
    contact_in_group_ids    = @account.client_ids - contact_in_group_ids
    

    @contacts                = Client.group_search(Client.where(id: contact_in_group_ids), params[:query]).order('full_name asc').page(params[:page]).per(16)

    
  end
  
  def new

    ClientGroupsClients.where(client_id: params[:contact_id], client_group_id: params[:contact_group_id])
                      .first_or_create(client_id: params[:contact_id], client_group_id: params[:contact_group_id])
    @contact_id = params[:contact_id]

  end
  
  def destroy

    if contact_group_contact = ClientGroupsClients.where(client_id: params[:id], client_group_id: params[:contact_group_id]).first
      contact_group_contact.destroy
      @contact_id = params[:id]
    end
  end
  
  

  
end
