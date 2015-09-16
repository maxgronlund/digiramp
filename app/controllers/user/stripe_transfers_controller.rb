class User::StripeTransfersController < ApplicationController
  before_action :access_user
  def index
   
   @stake = Stake.cached_find(params[:stake_id])
   @stripe_transfers = @stake.stripe_transfers
  end
end
