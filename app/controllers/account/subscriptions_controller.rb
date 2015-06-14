class Account::SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:show, :edit, :update, :destroy]
  include AccountsHelper
  before_action :access_account

  #def index
  #  @subscriptions = Subscription.all
  #end

  # GET /subscriptions/1
  # GET /subscriptions/1.json
  #def show
  #end

  # GET /subscriptions/new
  def new
    @user             = current_user
    @subscription     = Subscription.new
    @account_feature  = AccountFeature.where(account_type: 'Pro').first
      
  end

  # GET /subscriptions/1/edit
  def edit
  end

  # POST /subscriptions
  # POST /subscriptions.json
  def create
    @subscription = Subscription.new(subscription_params)
    
    if @subscription.save
      redirect_to account_account_account_users_path(@account)
      link_user
    else
      redirect_to new_account_account_subscription_path(@account)
    end


  end

  # PATCH/PUT /subscriptions/1
  # PATCH/PUT /subscriptions/1.json
  def update
    
    if @subscription.update(subscription_params)
      redirect_to account_account_account_users_path(@account)
      link_user
    else
      redirect_to edit_account_account_subscription_path(@account, @subscription)
    end

  end

  # DELETE /subscriptions/1
  # DELETE /subscriptions/1.json
  def destroy
    @subscription.destroy
    redirect_to account_account_account_users_path(@account)

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscription
      @subscription = Subscription.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subscription_params
      params.require(:subscription).permit(:email, :user_id, :account_id, :months)
    end
    
    def link_user
      
      if user = User.where(email: @subscription.email).first
        @subscription.user_id = user.id
        @subscription.save!
      else
        unlink_to_user
      end
    end
    
    def unlink_user
      @subscription.user_id = nil
      @subscription.save!
    end
end
