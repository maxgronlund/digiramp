class User::PublishingDesigneesController < ApplicationController
  def show
    
    @common_work = CommonWork.cached_find(params[:id])
    @user        = User.cached_find(params[:user_id])
    begin
      find_or_create_ip
      find_or_create_common_work_ipi                         
      find_or_create_recording_ipi
    rescue => e
      ErrorNotification.post_object 'User::PublishingDesigneesController#show', e
    end
    
    redirect_to user_user_common_work_path(@user, @common_work)
  end
  
  private
  
  def find_or_create_ip
    if @ipi = Ipi.find_by( user_id: @user.id )
    else 
      @ipi = Ipi.create( 
        user_id: @user.id,
        full_name: @user.full_name,
        email:     @user.email,
        share:      100,
        publishing_designee: true
      )
      @user.copy_address_to( @ipi.address )            
      @ipi.accepted! 
    end 
    
  end
  
  def find_or_create_common_work_ipi
    
    
     ap "@common_work.id; #{@common_work.id}"
     ap "@ipi.id #{@ipi.id}"
     ap "@user.personal_publishing_agreement.id #{@user.personal_publishing_agreement.id}"

    
    
    
    
    
    
    
    begin
      if @common_work_ipi = CommonWorkIpi.find_by(
          common_work_id:           @common_work.id,
          ipi_id:                   @ipi.id
        )
      else
        @common_work_ipi = CommonWorkIpi.create(
          common_work_id:               @common_work.id,
          ipi_id:                       @ipi.id,
          publishing_agreement_id:      @user.personal_publishing_agreement.id,
          share:                        100.0,    
          email:                        @user.email,
          alias:                        @user.user_name,
          full_name:                    @user.full_name,
          uuid:                         UUIDTools::UUID.timestamp_create().to_s
        )
        @common_work_ipi.accepted!
      end
    rescue => e
      ErrorNotification.post_object 'User::PublishingDesigneesController#find_or_create_common_work_ipi', e
    end
  end
  
  
  def find_or_create_recording_ipi
    ap 'find_or_create_recording_ipi'
    #return unless @common_work.recordings.count == 1
      
    @recording = @common_work.recordings.first
    begin
      if @recording_ipi = RecordingIpi.find_by( 
         user_id:        @user.id,
         recording_id:  @recording.id
        )
      else
        @recording_ipi = RecordingIpi.create( 
          user_id:   @user.id,
          recording_id:               @recording.id,
          share:                      100.00,
          name:                       @user.full_name,
          email:                      @user.email,
          confirmed:                  true,
          uuid:                       UUIDTools::UUID.timestamp_create().to_s,
          show_credit_on_recording:   false,
          account_id:                 @user.account.id,
          publishing_designee:        true,
          role:                       'Other',
          distribution_agreement:     @user.personal_distribution_agreement
        )
        ap @recording_ipi.accepted!
      end 
    rescue => e
      ErrorNotification.post_object 'User::PublishingDesigneesController#find_or_create_recording_ipi', e
    end
  end
  
  
end
