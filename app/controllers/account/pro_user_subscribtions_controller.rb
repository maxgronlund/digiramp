class Account::ProUserSubscribtionsController < ApplicationController
  before_action :set_pro_user_subscribtion, only: [:show, :edit, :update, :destroy]
  include AccountsHelper
  before_filter :access_account

  #def index
  #  @pro_user_subscribtions = ProUserSubscribtion.all
  #end

  # GET /pro_user_subscribtions/1
  # GET /pro_user_subscribtions/1.json
  #def show
  #end

  # GET /pro_user_subscribtions/new
  def new
    @pro_user_subscribtion = ProUserSubscribtion.new
  end

  # GET /pro_user_subscribtions/1/edit
  def edit
  end

  # POST /pro_user_subscribtions
  # POST /pro_user_subscribtions.json
  def create
    @pro_user_subscribtion = ProUserSubscribtion.new(pro_user_subscribtion_params)
    
    if @pro_user_subscribtion.save
      redirect_to account_account_account_users_path(@account)
      link_user
    else
      redirect_to new_account_account_pro_user_subscribtion_path(@account)
    end

    #respond_to do |format|
    #  if @pro_user_subscribtion.save
    #    format.html { redirect_to @pro_user_subscribtion, notice: 'Pro user subscribtion was successfully created.' }
    #    format.json { render :show, status: :created, location: @pro_user_subscribtion }
    #  else
    #    format.html { render :new }
    #    format.json { render json: @pro_user_subscribtion.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # PATCH/PUT /pro_user_subscribtions/1
  # PATCH/PUT /pro_user_subscribtions/1.json
  def update
    
    if @pro_user_subscribtion.update(pro_user_subscribtion_params)
      redirect_to account_account_account_users_path(@account)
      link_user
    else
      redirect_to edit_account_account_pro_user_subscribtion_path(@account, @pro_user_subscribtion)
    end
    #respond_to do |format|
    #  if @pro_user_subscribtion.update(pro_user_subscribtion_params)
    #    format.html { redirect_to @pro_user_subscribtion, notice: 'Pro user subscribtion was successfully updated.' }
    #    format.json { render :show, status: :ok, location: @pro_user_subscribtion }
    #  else
    #    format.html { render :edit }
    #    format.json { render json: @pro_user_subscribtion.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # DELETE /pro_user_subscribtions/1
  # DELETE /pro_user_subscribtions/1.json
  def destroy
    @pro_user_subscribtion.destroy
    redirect_to account_account_account_users_path(@account)

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pro_user_subscribtion
      @pro_user_subscribtion = ProUserSubscribtion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pro_user_subscribtion_params
      params.require(:pro_user_subscribtion).permit(:email, :user_id, :account_id)
    end
    
    def link_user
      
      if user = User.where(email: @pro_user_subscribtion.email).first
        @pro_user_subscribtion.user_id = user.id
        @pro_user_subscribtion.save!
      else
        unlink_to_user
      end
    end
    
    def unlink_user
      @pro_user_subscribtion.user_id = nil
      @pro_user_subscribtion.save!
    end
end
