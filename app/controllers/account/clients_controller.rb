class Account::ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]
  include AccountsHelper
  before_filter :access_account


  def index
    @clients  = Client.account_search(@account, params[:query]).order('name asc').page(params[:page]).per(256)
    @user = @account.user
    @authorized = true
  end


  def show
    @user = @account.user
    @authorized = true
  end


  def new
    @client = Client.new
    @user = @account.user
    @authorized = true
  end


  def edit
    @user = @account.user
    @authorized = true
  end


  def create
    
    if @client = Client.create(client_params)
      redirect_to account_account_client_path( @account, @client)
    else
      redirect_to edit_account_account_client_path( @account, @client)
    end


  end


  def update
    if @client.update(client_params)
      redirect_to account_account_client_path( @account, @client)
    else
      redirect_to edit_account_account_client_path( @account, @client)
    end

  end


  def destroy
    @client.destroy
    redirect_to account_account_clients_path( @account)

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.require(:client).permit!
    end
end
