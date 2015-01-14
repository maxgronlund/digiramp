class User::ContactGroupsController < ApplicationController
  
  before_filter :access_user
  #include AccountsHelper
  #before_filter :access_account
  


  def index
    account = @user.account
    @contact_groups = account.client_groups
  end

  def show
     @contact_group = ClientGroup.cached_find(params[:id])
  end
  
  def new
  end
  
  def create
    ap params
    @contact_group = ClientGroup.create(client_group_params)
    ap @contact_group
    redirect_to edit_user_user_contact_group_path(@user, @contact_group)
  end

  def update
  end

  def edit
    @contact_group = ClientGroup.cached_find(params[:id])
  end

  def delete
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def client_group_params
    params.require(:client_group).permit!
  end
  
  
end
