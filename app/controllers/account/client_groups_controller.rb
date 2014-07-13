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
    @client_group = ClientGroup.new(client_group_params)

    respond_to do |format|
      if @client_group.save
        format.html { redirect_to @client_group, notice: 'Client group was successfully created.' }
        format.json { render :show, status: :created, location: @client_group }
      else
        format.html { render :new }
        format.json { render json: @client_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /client_groups/1
  # PATCH/PUT /client_groups/1.json
  def update
    respond_to do |format|
      if @client_group.update(client_group_params)
        format.html { redirect_to @client_group, notice: 'Client group was successfully updated.' }
        format.json { render :show, status: :ok, location: @client_group }
      else
        format.html { render :edit }
        format.json { render json: @client_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /client_groups/1
  # DELETE /client_groups/1.json
  def destroy
    @client_group.destroy
    respond_to do |format|
      format.html { redirect_to client_groups_url, notice: 'Client group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_group
      @client_group = ClientGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_group_params
      params.require(:client_group).permit(:title, :account_id)
    end
end
