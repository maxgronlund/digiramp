class Account::CommonWorksController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
  include AccountsHelper
  before_action :access_account
  
  def index
    forbidden unless super? || current_account_user 
    
    @user = @account.user
    @common_works  = CommonWork.account_search(@account, params[:query]).order('title asc').page(params[:page]).per(32)
    respond_to do |format|
      format.html
      format.csv { render text: @common_works.to_csv }
    end
  end

  def show
    forbidden unless super? || current_account_user.read_common_work
    @user = @account.user
    @common_work    = CommonWork.cached_find(params[:id])
    
    @common_work.create_activity(  :show, 
                              owner: current_user,
                          recipient: @common_work,
                     recipient_type: @common_work.class.name,
                         account_id: @account.id)
                         
  end
  
  def new
    @common_work    = CommonWork.new
  end
  
  def create
    forbidden unless super? || current_account_user.create_common_work
    artwork_url = TransloaditImageParser.get_image_url params[:transloadit]

    # extract  parameters
    params[:common_work]            = params["common_work"]
    
    # set the artwork url if any
    params[:common_work][:artwork]  = artwork_url if artwork_url
    

    if @common_work = CommonWork.create(common_work_params)
      
      log_state :created
      #@common_work.create_activity(  :created, 
      #                          owner: current_user,
      #                      recipient: @common_work,
      #                 recipient_type: @common_work.class.name,
      #                     account_id: @account.id)
      #                     
      #              
      #@common_work.update_completeness
      
      render :show
    else
      render :new
    end
  end
  
  
  
  def edit
    forbidden unless super? || current_account_user.update_common_work
    @common_work    = CommonWork.find(params[:id])
  end
  
  def update
    forbidden unless super? || current_account_user.update_common_work
    artwork_url = TransloaditImageParser.get_image_url params[:transloadit]

    # extract  parameters
    params[:common_work] = params["common_work"]
    
    # set the artwork url if any
    params[:common_work][:artwork]  = artwork_url if artwork_url

    
    @common_work    = CommonWork.cached_find(params[:id])
    if @common_work.update_attributes(common_work_params)
      
      log_state :updated
      #@common_work.create_activity(  :updated, 
      #                          owner: current_user,
      #                      recipient: @common_work,
      #                 recipient_type: @common_work.class.name,
      #                     account_id: @account.id)
      #                     
      #@common_work.update_completeness
      redirect_to_return_url account_account_common_work_path(@account, @common_work)
    else
      render :edit
    end
  end
  
  def recordings
    forbidden unless super? || current_account_user.read_common_work
    @common_work    = CommonWork.cached_find(params[:id])
  end
  
  def recordings_new
    forbidden unless super? || current_account_user.update_common_work
    forbidden unless super? || current_account_user.create_recording
    @common_work    = CommonWork.cached_find(params[:id])
  end
  
  def recordings_create
    forbidden unless super? || current_account_user.update_common_work
    forbidden unless super? || current_account_user.create_recording?
    
    @common_work           = CommonWork.cached_find(params[:id])
    
    #begin
      #TransloaditParser.add_to_common_work params[:transloadit], @common_work.id, @account.id
      if result = TransloaditRecordingsParser.parse( params[:transloadit],  @account.id, false, @account.user_id)
        if result[:recordings].size != 0
      
          result[:recordings].each do |recording|
            recording.common_work_id = @common_work.id
            recording.save!
                  
            #current_user.create_activity(  :created, 
            #                           owner: recording,
            #                       recipient: current_account_user.user,
            #                  recipient_type: 'Recording',
            #                      account_id: current_user.account_id) 
            #                  
            #
            
          end
        end
        
      end
    
      redirect_to account_account_common_work_path(@account, @common_work )


  end
  
  def destroy
    forbidden unless super? || current_account_user.delete_common_work
    @common_work    = CommonWork.cached_find(params[:id])
    @common_work.destroy
    redirect_to account_account_common_works_path @account

  end
  
  private
  def log_state state
    @common_work.create_activity(  state, 
                              owner: current_user,
                          recipient: @common_work,
                     recipient_type: @common_work.class.name,
                         account_id: @account.id)
                                 
    @common_work.update_completeness
  end
  
  def common_work_params
    params.require(:common_work).permit!
  end
  
  
  
end
