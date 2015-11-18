class User::FromGmailController < ApplicationController
  before_action :access_user
  include AccountsHelper
  
  def new
    #'fo'
    #@user.set_go_to nil
    #CloudSpongeJob.perform_later @user
    
   
   
  end

  def create
  end  
  
  def index
   
  end
  
  def show
    #ap params
    #ap '=================================='
    #ap @user.get_google_url
    #ap '.'
    ## render json: {guid: @shop_order.id, status: @shop_order.state, error: @shop_order.error}
    #if google_url = @user.get_google_url
    #  render json: {utl: @user.get_google_url, status: 'finished'}
    #else
    #  render json: {utl: @user.get_google_url, status: 'ok'}
    #end
  end
  
  
  
  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def client_import_params
    #params.require(:client_import).permit(:account_id,:user_uuid,:file,:user_id,:source)
  end
end

