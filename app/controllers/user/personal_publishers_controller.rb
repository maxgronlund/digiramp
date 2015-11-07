# Configure the publishing type for a user
class User::PersonalPublishersController < ApplicationController
  before_action :access_user
  
  def index
    @publishers = Publisher.where(user_id: @user.id, personal_publisher: true)
    
  end

  
  
  def edit
    @user_publisher = UserPublisher.new
  end
  #
  #def new
  #  
  #end
  
  def update
    @user.update(user_params)
    
    
    case @user.personal_publishing_status
      
    when 'I own and control my own publishing'
      remove_all_uper_publishers
      attach_personal_publisher_to_common_work_ipis
      personal_publisher = @user.personal_publisher
      @user.attach_common_work_ipis_to_personal_publisher

      unless @user.personal_publisher.confirmed_publishing?(@user.id)
        if personal_publisher.address_line_1.blank?
          go_to =   edit_user_user_publisher_legal_info_path(@user, personal_publisher)
        else
          go_to = user_user_legal_index_path(@user)
        end
      end
    when 'I have an exclusive publisher'
      
    when 'I have many publishers'
      go_to = edit_user_personal_publisher_path(@user)
    when 'I have an administrator'

    end
    
    @user.common_work_ipis.each do |common_work_ipi|
      common_work_ipi.update_validation
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
  
  def remove_all_uper_publishers
    begin
      @user.user_publishers.destroy_all
    rescue => e
      ErrorNotification.post( "PersonalPublisherController#remove_all_uper_publishers#{e}" )
    end
  end
  
  def attach_personal_publisher_to_common_work_ipis
    
    if publisher = @user.personal_publisher
      @user.common_work_ipis.each do |common_work_ipi|
          UserPublisher.where(
          user_id:         @user.id,
          publisher_id:    publisher.id,
          email:           publisher.email
        )
        .first_or_create(
          user_id:         @user.id,
          publisher_id:    publisher.id,
          email:           publisher.email
        )
      end
    end
  end
  
  
  
end
