class CommonWorksController < ApplicationController
  #include Transloadit::Rails::ParamsDecoder
  #include AccountsHelper
  #before_action :access_account
  

  
  def update
    
    recording_id    = params[:common_work][:recording_id]
    user_id         = params[:common_work][:user_id]
    params[:common_work].delete :recording_id
    params[:common_work].delete :user_id
    
    params[:common_work] = params["common_work"] 

    @common_work    = CommonWork.cached_find(params[:id])
    
    if  params[:common_work][:ipis_attributes]
      if @common_work.update_attributes(common_work_params)
        
        @common_work.create_activity(  :updated, 
                                  owner: current_user,
                              recipient: @common_work,
                         recipient_type: @common_work.class.name,
                             account_id: @common_work.account_id)
                             
        @common_work.update_completeness
        @common_work.attache_ipis_true recording_id
        redirect_to user_recording_path( user_id, recording_id)
      else
        redirect_to :back
      end
    else
      redirect_to user_recording_path( user_id, recording_id)
    end
  end
  

  
  
private
  
  def common_work_params
    params.require(:common_work).permit(
      :id,
      :title,
      :iswc_code,
      :created_at,
      :updated_at,
      :ascap_work_id,
      :account_id,
      :common_works_import_id,
      :content_type,
      :description,
      :alternative_titles,
      :step,
      :lyrics,
      :catalog_id,
      :uuid,
      :completeness,
      :pro,
      :surveyed_work,
      :last_distribution,
      :work_status,
      :work_type,
      :registration_date,
      :registration_origin,
      :arrangement,
      :ok ,
      ipis_attributes: [  
        :id,
        :full_name,
        :address,
        :email,
        :phone_number,
        :role,
        :created_at,
        :updated_at,
        :user_id,
        :ipi_code,
        :cae_code,
        :uuid,
        :pro_affiliation_id,
        :ok,
        :_destroy
      ]                  
      
    )
  end
  
  
end
