class User::PublishingDesigneesController < ApplicationController
  
  # assign all the apropiated rights to the common_work
  # so the work is ready for publishing
  before_action :access_user
  
  def show
    @common_work = CommonWork.cached_find(params[:id])
    
    begin
      create_common_work_ipi 
      create_common_work_user
      create_common_work_ipi_publisher                        
    rescue => e
      ErrorNotification.post_object 'User::PublishingDesigneesController#show', e
    end
    
    redirect_to user_user_common_work_path(@user, @common_work)
  end
  
  private
  

  
  def create_common_work_ipi

    @common_work_ipi = CommonWorkIpi.where(
      common_work_id:               @common_work.id,
      ipi_id:                       @user.ipi.id
    )
    .first_or_create(
      common_work_id:               @common_work.id,
      ipi_id:                       @user.ipi.id,
      email:                        @user.email,
      alias:                        @user.user_name,
      full_name:                    @user.get_full_name,
      publishing_agreement_id:      @user.personal_publishing_agreement.id, 
      user_id:                      @user.id,
      publisher_id:                 @user.personal_publisher_id,
      uuid:                         UUIDTools::UUID.timestamp_create().to_s, 
      share:                        100.0, 
      can_edit_common_work:         true
    )
    @common_work_ipi.confirmed!
  end
  
  def create_common_work_user
    CommonWorkUser.where(
      user_id:        @user.id,
      common_work_id: @common_work.id
    )
    .first_or_create(
      user_id:        @user.id,
      common_work_id: @common_work.id,
      common_work_title: @common_work.title,
      can_manage_common_work: true
    )
  end
  
  def create_common_work_ipi_publisher
    @common_work_ipi_publisher = CommonWorkIpiPublisher.where(
      common_work_ipi_id:          @common_work_ipi.id,
      publisher_id:                @common_work_ipi.publisher_id
    )
    .first_or_create(
      common_work_ipi_id:          @common_work_ipi.id,
      publisher_id:                @common_work_ipi.publisher_id,
      publishing_split:            @common_work_ipi.publishing_agreement.split,
      publishing_agreement_id:     @common_work_ipi.publishing_agreement_id,
    )
    
  end
  

  
  
  #def find_or_create_recording_ipi
  #  #ap 'find_or_create_recording_ipi'
  #  #return unless @common_work.recordings.count == 1
  #    
  #  @recording = @common_work.recordings.first
  #  begin
  #    if @recording_ipi = RecordingIpi.find_by( 
  #       user_id:        @user.id,
  #       recording_id:  @recording.id
  #      )
  #    else
  #      @recording_ipi = RecordingIpi.create( 
  #        user_id:   @user.id,
  #        recording_id:               @recording.id,
  #        share:                      100.00,
  #        name:                       @user.full_name,
  #        email:                      @user.email,
  #        confirmed:                  true,
  #        uuid:                       UUIDTools::UUID.timestamp_create().to_s,
  #        show_credit_on_recording:   false,
  #        account_id:                 @user.account.id,
  #        publishing_designee:        true,
  #        role:                       'Other',
  #        distribution_agreement:     @user.personal_distribution_agreement
  #      )
  #      #ap @recording_ipi.accepted!
  #    end 
  #  rescue => e
  #    ErrorNotification.post_object 'User::PublishingDesigneesController#find_or_create_recording_ipi', e
  #  end
  #end
  
  
end
