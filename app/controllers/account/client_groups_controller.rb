class Account::ClientGroupsController < ApplicationController
  
  include AccountsHelper
  before_action :access_account
  before_action :set_client_group, only: [:show, :edit, :update, :destroy, :import_client_emails, :remove_member]
  
  # GET /client_groups
  # GET /client_groups.json
  def index
    
    @client_groups = ClientGroup.all
    @user = @account.user
    @authorized = true
  end

  # GET /client_groups/1
  # GET /client_groups/1.json
  def show
    
    @user = @account.user
    @authorized = true
  end

  # GET /client_groups/new
  def new
    
    @client_group = ClientGroup.new
    @user = @account.user
    @authorized = true
  end

  # GET /client_groups/1/edit
  def edit
    
    @user = @account.user
    @authorized = true
  end

  # POST /client_groups
  # POST /client_groups.json
  def create
    
    @client_group = ClientGroup.create(client_group_params)
    redirect_to account_account_client_groups_path(@account)
    
  end

  # PATCH/PUT /client_groups/1
  # PATCH/PUT /client_groups/1.json
  def update
    
    if @client_group.update(client_group_params)
      redirect_to account_account_client_group_path(@account, @client_group)
    else
      redirect_to edit_account_account_client_group_path(@account, @client_group)
    end  
  end

  # DELETE /client_groups/1
  # DELETE /client_groups/1.json
  def destroy
    @client_group.destroy
    redirect_to account_account_client_groups_path(@account)
  end


  def import_client_emails
    emails = params[:emails].split(',')
    emails.each do |email|
      
      if EmailSanitizer.saintize email
      
        client = Client.where(email:email).first_or_create(email:email, name:email, show_alert: true)
        
        ClientGroupsClients.where(client_group_id: @client_group.id, client_id: client.id
                                  ).first_or_create(client_group_id: @client_group.id,
                                  client_id: client.id)
      end
    end  
    redirect_to account_account_client_group_path(@account.id, @client_group.id)
      
  end
  
     

  def remove_member
    client_groups_client = ClientGroupsClients.where(id: params[:client_group_client_id].to_i, client_group_id: @client_group.id).first
    if client_groups_client.destroy

    else
      flash[:error] = "Requested member does not exists for this group."
    end
    redirect_to account_account_client_group_path(@account.id, @client_group.id)
  end

  private
    
    # Use callbacks to share common setup or constraints between actions.
    def set_client_group
      id = params[:id] ||= params[:client_group_id]
      @client_group = ClientGroup.cached_find(id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_group_params
      params.require(:client_group).permit!
    end

end
