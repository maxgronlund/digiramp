# Configure the publishing type for a user
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
    
    
    case @user.personal_publishing_status
      
    when 'I own and control my own publishing'
      personal_publisher = @user.personal_publisher
      unless @user.personal_publisher.confirmed_publishing?(@user.id)
        go_to =   edit_user_user_publisher_legal_info_path(@user, personal_publisher)
      end
    when 'I have an exclusive publisher'
      
    when 'I have many publishers'
      
    when 'I have an administrator'


    end
    redirect_to  go_to || user_user_legal_index_path(@user)
  end
    
  
  
  #def create
  #  
  #end
  
  private
  def user_params
    params.require(:user).permit!#( UserParams::PUBLIC_PARAMS ) 
  end
  
  
end
