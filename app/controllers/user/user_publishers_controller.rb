class User::UserPublishersController < ApplicationController
  before_action :access_user
  
  
  def create
    
    if publisher = Publisher.find_by(email: params[:user_publisher][:email])
      params[:user_publisher][:publisher_id] = publisher.id
    end
    
    if publisher && UserPublisher.find_by(
        user_id: params[:user_publisher][:user_id],
        publisher_id: params[:user_publisher][:publisher_id]
      )
      flash[:warning] = "Publisher already added"
    else
      UserPublisher.create(user_publisher_params)
      flash[:info] = "Publisher added" 
    end
    
    redirect_to edit_user_personal_publisher_path(@user)
  end
  
  def destroy
    
  end
  
  private
  

  def user_publisher_params
    params.require(:user_publisher).permit!#( UserParams::PUBLIC_PARAMS ) 
  end
end
