class User::StakesController < ApplicationController
  before_action :set_stake, only: [:show, :edit, :update, :destroy]
  before_action :set_shop_product
  before_action :access_user
  
  def index
    not_found unless @shop_product
  end

  def new
  end

  def create
    ap params
    Stake.create!(stake_params)
    redirect_to user_user_product_stakes_path(@user, @shop_product)
  end

  def edit
  end

  def update
  end

  def destroy
    @stake.destroy
    redirect_to user_user_product_stakes_path(@user, @shop_product)
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
      params.require(:stake).permit!
    end
end
