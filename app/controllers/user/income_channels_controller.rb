class User::IncomeChannelsController < ApplicationController
  before_action :access_user
  before_action :set_stake, only: [:update, :destroy, :show]

  def index
    @stakes = Stake.where(account_id:  @user.account.id )
  end
  
  def show
    
  end
  
  def create
    Stake.create!(stake_params)
    redirect_to user_user_income_channel_path(@user, @stake)
  end
  
  private
  
    def set_stake
      @stake = Stake.cached_find(params[:id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def stake_params
      params.require(:stake).permit!
    end
  
  
end
