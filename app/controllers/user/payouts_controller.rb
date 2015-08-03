class User::PayoutsController < ApplicationController
  before_action :access_user
  def index
    @stripe_transfers = @user.stripe_transfers.order(:created_at)
    
    #@stripe_transfers.where(state: 'pending').each do |stripe_transfer|
    #  stripe_transfer.pay
    #end
    #redirect_to :back
  end

  
end
