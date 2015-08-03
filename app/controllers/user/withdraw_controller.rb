class User::WithdrawController < ApplicationController
  before_action :access_user
  
  def index
    @user.stripe_transfers.where(state: 'pending').each do |stripe_transfer|
      stripe_transfer.pay
      ap stripe_transfer
    end
    #render nothing: true
  end
end
