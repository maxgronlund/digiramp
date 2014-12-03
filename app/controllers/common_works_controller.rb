class CommonWorksController < ApplicationController
  #include Transloadit::Rails::ParamsDecoder
  #include AccountsHelper
  #before_filter :access_account
  
  # show list or export as cvs
  #def index
  #  @common_works  = CommonWork.account_search(@account, params[:query]).order('title asc').page(params[:page]).per(32)
  #  respond_to do |format|
  #    format.html
  #    #format.csv { render text: @common_works.to_csv }
  #    format.csv { render text: @common_works.to_csv }
  #  end
  #end
  #
  #def show
  #  forbidden unless current_account_user.read_common_work
  #  @common_work    = CommonWork.cached_find(params[:id])
  #  
  #  @common_work.create_activity(  :show, 
  #                            owner: current_user,
  #                        recipient: @common_work,
  #                   recipient_type: @common_work.class.name,
  #                       account_id: @account.id)
  #                       
  #end
  #
  #def new
  #  @common_work    = CommonWork.new
  #end
  #
  #def create
  #  forbidden unless current_account_user.create_common_work
  #  artwork_url = TransloaditImageParser.get_image_url params[:transloadit]
  #
  #  # extract  parameters
  #  params[:common_work]            = params["common_work"]
  #  
  #  # set the artwork url if any
  #  params[:common_work][:artwork]  = artwork_url if artwork_url
  #  
  #
  #  if @common_work = CommonWork.create(common_work_params)
  #    
  #    @common_work.create_activity(  :created, 
  #                              owner: current_user,
  #                          recipient: @common_work,
  #                     recipient_type: @common_work.class.name,
  #                         account_id: @account.id)
  #                         
  #                  
  #    @common_work.update_completeness
  #    render :show
  #  else
  #    render :new
  #  end
  #end
  #
  #def edit
  #  forbidden unless current_account_user.update_common_work
  #  @common_work    = CommonWork.find(params[:id])
  #end
  
  def update

    recording_id   = params[:common_work][:recording_id]
    user_id       = params[:common_work][:user_id]
    params[:common_work].delete :recording_id
    params[:common_work].delete :user_id
    #forbidden unless current_account_user.update_common_work
    #artwork_url = TransloaditImageParser.get_image_url params[:transloadit]

    # extract  parameters
    params[:common_work] = params["common_work"]
    
    # set the artwork url if any
    #params[:common_work][:artwork]  = artwork_url if artwork_url

    
    @common_work    = CommonWork.cached_find(params[:id])
    if @common_work.update_attributes(common_work_params)
      
      @common_work.create_activity(  :updated, 
                                owner: current_user,
                            recipient: @common_work,
                       recipient_type: @common_work.class.name,
                           account_id: @common_work.account_id)
                           
      @common_work.update_completeness
      
      redirect_to user_recording_path( user_id, recording_id)
      #redirect_to_return_url account_account_common_work_path(@account, @common_work)
    else
      redirect_to :back
    end
  end
  
  
  
private
  
  def common_work_params
    params.require(:common_work).permit(
                                            :common_works,
                                            :title,
                                            :iswc_code,
                                            :created_at,                        
                                            :updated_at,                     
                                            :ascap_work_id,
                                            :account_id,
                                            :common_works_import_id,
                                            :audio_file,
                                            :content_type,
                                            :description,
                                            :alternative_titles,
                                            :recording_preview_id,
                                            :step,                           
                                            :lyrics,
                                            :catalog_id,
                                            :uuid,
                                            :completeness,
                                            :artwork,
                                            :pro,
                                            :surveyed_work,
                                            :last_distribution,
                                            :work_status,
                                            :ascap_award_winner,
                                            :work_type,
                                            :composite_type,
                                            :arrangement_of_public_domain_work,
                                            :genre,
                                            :submitter_work_id,
                                            :registration_date,               
                                            :bmi_work_id,                   
                                            :bmi_catalog,                     
                                            :registration_origin,             
                                            :pro_work_id,                       
                                            :pro_catalog,    
                                            ipis_attributes: [  :id, 
                                                                :full_name,
                                                                :address,
                                                                :email,
                                                                :phone_number,
                                                                :role,
                                                                :common_work_id,
                                                                :import_ipi_id,
                                                                :created_at,            
                                                                :updated_at,            
                                                                :user_id,
                                                                :ipi_code,
                                                                :cae_code,
                                                                :controlled,
                                                                :territory,
                                                                :share,                 
                                                                :mech_owned,            
                                                                :mech_collected,        
                                                                :perf_owned,            
                                                                :perf_collected,        
                                                                :notes,
                                                                :pro,
                                                                :has_agreement,
                                                                :linked_to_ascap_member,
                                                                :controlled_by_submitter,
                                                                :ascap_work_id,
                                                                :bmi_work_id,           
                                                                :writer,                
                                                                :composer,              
                                                                :administrator,         
                                                                :producer,              
                                                                :original_publisher,    
                                                                :artist,                
                                                                :distributor,           
                                                                :remixer,               
                                                                :other,                 
                                                                :publisher,    
                                                                :_destroy]                  
      
                                            )
  end
  
  
end
