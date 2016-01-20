class User::RevenueStreamsController < ApplicationController
  before_action :access_user
  before_action :set_stake, only: [:update, :destroy, :show]

  def index
    @stakes = Stake.where(account_id:  @user.account.id )
  end
  
  def show
   
  end
  

  
  def create

    Notifyer.print( 'User::RevenueStreamsController#create' , params: params ) if Rails.env.development?
    
    stake       = Stake.new(stake_params)
    stake.flat_rate_in_cent   *= stake.split * 0.01
    
    if stake.save
      redirect_to user_user_revenue_stream_path(@user, stake.asset_id)
    else
      @stake = Stake.find(params[:stake][:asset_id])
      params[:id] = params[:stake][:asset_id]
      flash[:danger] = "Total split can't exceed 100%" 
      render :show
    end
  end
  
  def destroy
    @stake.destroy!
    redirect_to user_user_revenue_stream_path(@user, params[:stake_id])
  end
  
  private
  
    def set_stake
      @stake = Stake.cached_find(params[:id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def stake_params
      params.require(:stake).permit!
      #(:account_id,
      #                              :split,
      #                              :flat_rate_in_cent,
      #                              :currency,
      #                              :email,
      #                              :ipiable_id,
      #                              #:ipiable_type,
      #                              #:channel_uuid,
      #                              :asset_id,
      #                              :asset_type,
      #                              :original_source
      #                              )
    end
  
  
end
