class User::ContactGroupsController < ApplicationController
  
  before_filter :access_user
  #include AccountsHelper
  #before_filter :access_account
  


  def index
    account = @user.account
    @contact_groups = account.client_groups
    
  end

  def show
     @contact_group  = ClientGroup.cached_find(params[:id])
     @contacts       = @contact_group.clients.order('full_name asc')
  end
  
  def new
  end
  
  def create

    @contact_group = ClientGroup.create(client_group_params)

    redirect_to user_user_contact_group_path(@user, @contact_group)
  end

  def update
    @contact_group = ClientGroup.cached_find(params[:id])
    @contact_group.update(client_group_params)
    redirect_to user_user_contact_group_path(@user, @contact_group)
  end

  def edit
    @contact_group = ClientGroup.cached_find(params[:id])
  end

  def destroy
    contact_group  = ClientGroup.cached_find(params[:id])
    @contact_group_id  = contact_group.id
    contact_group.destroy
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def client_group_params
    params.require(:client_group).permit!
  end
  
  def toggle_selection
    session[:select_all_recordings] = session[:select_all_recordings] ? false : true
    render nothing: true
  end
  
  def add_selected
    contact_group      = ClientGroup.cached_find(params[:contact_group_id])
    
    ap '======================= add selected =============================='
    render nothing: true
  end
  
  def add_all
    ap '======================= add all =============================='
    
    @user.clients.each do |client|
      ClientGroupsClients.where(client_id: client.id, client_group_id: params[:contact_group_id])
                         .first_or_create(client_id: client.id, client_group_id: params[:contact_group_id])
      
    end

    render nothing: true
  end
  
  
end
