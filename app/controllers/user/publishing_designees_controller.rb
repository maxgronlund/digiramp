class User::PublishingDesigneesController < ApplicationController
  def show

    @common_work = CommonWork.cached_find(params[:id])
    @user        = User.cached_find(params[:user_id])
    
    @ipi         = Ipi.where(common_work_id: @common_work.id, user_id: @user.id)
                      .first_or_create( user_id: @user.id,
                                                common_work_id: @common_work.id,
                                                full_name: @user.full_name,
                                                email:     @user.email,
                                                share:      100,
                                                publishing_designee: true
                                                )
                                                
    @ipi.accepted!                          
    @user.copy_address_to( @ipi.address )
    attach_to_publishing_agreement
    attach_recording_ipi
    redirect_to :back
  end
  
  private
  
  def attach_to_publishing_agreement
    publishing_agreement  = @user.publishing_agreement
    
    IpiPublishingAgreement.where(ipi_id: @ipi.id, publishing_agreement_id: publishing_agreement.id)
                      .first_or_create(ipi_id: @ipi.id, publishing_agreement_id: publishing_agreement.id)
    
  end
  
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
                                                 confirmation:               'Confirmed',
                                                 uuid:                       UUIDTools::UUID.timestamp_create().to_s,
                                                 show_credit_on_recording:   false,
                                                 account_id:                 @user.account.id,
                                                 publishing_designee:        true,
                                                 role:                       'Other'
                                               )
    recording_ipi.accepted!
    
  end
  
  
end
