class User::PersonalPublishersController < ApplicationController
  before_action :access_user
  
  def index
    @publishers = Publisher.where(user_id: @user.id, personal_publisher: true)
    
  end

  
  #
  #def edit
  #  @publisher = Publisher.cached_find(params[:id])
  #end
  #
  #def new
  #  
  #end
  
  def update

    @user.update(user_params)
    ap @user
    redirect_to user_user_personal_publishers_path(@user)
  end
    
  
  
  def create
    
  end
  
  private
  def user_params
    params.require(:user).permit!#( UserParams::PUBLIC_PARAMS ) 
  end
  
  
end
