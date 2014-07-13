class Account::ClientGroupsController < ApplicationController
  before_action :set_client_group, only: [:show, :edit, :update, :destroy]
  include AccountsHelper
  before_filter :access_account
  
  # GET /client_groups
  # GET /client_groups.json
  def index
    @client_groups = ClientGroup.all
  end

  # GET /client_groups/1
  # GET /client_groups/1.json
  def show
  end

  # GET /client_groups/new
  def new
    @client_group = ClientGroup.new
  end

  # GET /client_groups/1/edit
  def edit
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_group
      @client_group = ClientGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_group_params
      params.require(:client_group).permit!
    end
end
