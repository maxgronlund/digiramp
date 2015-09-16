class User::StakesController < ApplicationController
  before_action :set_stake, only: [:show, :edit, :update, :destroy]
  before_action :set_shop_product, only: [:show, :edit, :index, :create]
  before_action :access_user
  
  def index

    if recording = @shop_product.recording
      @stakes =  recording.stakes
    end
  end

  def new
  end

  def create
    Stake.create!(stake_params)
    redirect_to user_user_product_stakes_path(@user, @shop_product)
  end

  def edit
  end

  def update
    @stake.update(stake_params)
    redirect_to_return_url :back
  end

  def destroy
    @stake.destroy
    redirect_to user_user_revenue_streams_path(@user)
  end
  
  private
  
  def set_shop_product
    @shop_product = Shop::Product.cached_find(params[:product_id])
  end
  
  def set_stake
    @stake = Stake.cached_find(params[:id])
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def stake_params
    params.require(:stake).permit(:account_id,
                                  :split,
                                  :flat_rate_in_cent,
                                  :currency,
                                  :email,
                                  :unassigned,
                                  :channel_uuid,
                                  :asset_id,
                                  :asset_type
                                  )
  end
end



               