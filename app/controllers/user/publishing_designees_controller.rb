class User::PublishingDesigneesController < ApplicationController
  def show
    ap 'show'
    @common_work = CommonWork.cached_find(params[:id])
    @user        = User.cached_find(params[:user_id])
    
    @ipi         = Ipi.where(user_id: @user.id)
                      .first_or_create( user_id: @user.id,
                                       full_name: @user.full_name,
                                       email:     @user.email,
                                       share:      100,
                                       publishing_designee: true
                                       )
                                                
    @ipi.accepted!                          
    @user.copy_address_to( @ipi.address )
    common_work_ipi = CommonWorkIpi.create(
      common_work_id:               @common_work.id,
      ipi_id:                       @ipi.id,
      publishing_agreement_id:      @user.personal_publishing_agreement.id,
      share:                        100.0,    
      email:                        @user.email,
      alias:                        @user.user_name,
      full_name:                    @user.full_name
    )
    common_work_ipi.accepted!

    attach_recording_ipi
    redirect_to user_user_common_work_path(@user, @common_work)
  end
  
  private
  
  
  
  def attach_recording_ipi
    return unless @common_work.recordings.count == 1
      
    recording = @common_work.recordings.first
    
    recording_ipi = RecordingIpi.where( user_id:                    @user.id,
                                        recording_id:               recording.id
                                      )
                               .first_or_create( user_id:                    @user.id,
                                                 recording_id:               recording.id,
                                                 share:                      100.00,
                                                 name:                       @user.full_name,
                                                 email:                      @user.email,
                                                 confirmed:                  true,
                                                 uuid:                       UUIDTools::UUID.timestamp_create().to_s,
                                                 show_credit_on_recording:   false,
                                                 account_id:                 @user.account.id,
                                                 publishing_designee:        true,
                                                 role:                       'Other'
                                               )
    recording_ipi.accepted!
    
  end
  
  
end
