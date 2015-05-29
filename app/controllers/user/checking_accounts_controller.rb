class User::CheckingAccountsController < ApplicationController
  def show
    @user = User.first
  end
  
  def new
    ap params
    @user = User.first
  end
  
  def create
    ap params
    @user = User.first
    
    #recipient = Stripe::Recipient.create(
    #  name: params[:fullName],
    #  type: 'individual',
    #  bank_account: params[:stripeToken]
    #)
    #
    #@user.stripe_recipient_id = recipient.id
    #@user.save!
    #
    #transfer = Stripe::Transfer.create(
    #  amount: 10000,
    #  currency: 'usd',
    #  recipient: @user.stripe_recipient_id,
    #  description: 'Transfer'
    #)
    #
    #
    redirect_to :back
  end
  
  def edit
    @user = User.first
  end
end
