class Account::ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]
  include AccountsHelper
  before_filter :access_account

  # GET /clients
  # GET /clients.json
  def index
    @clients  = Client.account_search(@account, params[:query]).order('name asc').page(params[:page]).per(32)
    #respond_to do |format|
    #  format.html
    #  #format.csv { render text: @common_works.to_csv }
    #  format.csv { render text: @clients.to_csv }
    #end
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
  end

  # GET /clients/new
  def new
    @client = Client.new
  end

  # GET /clients/1/edit
  def edit
  end

  # POST /clients
  # POST /clients.json
  def create
    
    if @client = Client.create(client_params)
      redirect_to account_account_client_path( @account, @client)
    else
      redirect_to edit_account_account_client_path( @account, @client)
    end

    #respond_to do |format|
    #  if @client.save
    #    format.html { redirect_to @client, notice: 'Client was successfully created.' }
    #    format.json { render :show, status: :created, location: @client }
    #  else
    #    format.html { render :new }
    #    format.json { render json: @client.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    if @client.update(client_params)
      redirect_to account_account_client_path( @account, @client)
    else
      redirect_to edit_account_account_client_path( @account, @client)
    end

  end

  # DELETE /clients/1
  # DELETE /clients/1.json
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
