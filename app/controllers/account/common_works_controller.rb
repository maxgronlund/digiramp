class Account::CommonWorksController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
  include AccountsHelper
  #before_filter :access_account
  before_filter :get_account_account
  # show list or export as cvs
  
  def index
    
    forbidden unless current_account_user 
    @user = current_user
    @common_works  = CommonWork.account_search(@account, params[:query]).order('title asc').page(params[:page]).per(32)
    respond_to do |format|
      format.html
      format.csv { render text: @common_works.to_csv }
    end
  end

  def show
    forbidden unless current_account_user.read_common_work
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
    forbidden unless current_account_user.create_common_work
    artwork_url = TransloaditImageParser.get_image_url params[:transloadit]

    # extract  parameters
    params[:common_work]            = params["common_work"]
    
    # set the artwork url if any
    params[:common_work][:artwork]  = artwork_url if artwork_url
    

    if @common_work = CommonWork.create(common_work_params)
      
      @common_work.create_activity(  :created, 
                                owner: current_user,
                            recipient: @common_work,
                       recipient_type: @common_work.class.name,
                           account_id: @account.id)
                           
                    
      @common_work.update_completeness
      render :show
    else
      render :new
    end
  end
  
  def edit
    forbidden unless current_account_user.update_common_work
    @common_work    = CommonWork.find(params[:id])
  end
  
  def update
    forbidden unless current_account_user.update_common_work
    artwork_url = TransloaditImageParser.get_image_url params[:transloadit]

    # extract  parameters
    params[:common_work] = params["common_work"]
    
    # set the artwork url if any
    params[:common_work][:artwork]  = artwork_url if artwork_url

    
    @common_work    = CommonWork.cached_find(params[:id])
    if @common_work.update_attributes(common_work_params)
      
      @common_work.create_activity(  :updated, 
                                owner: current_user,
                            recipient: @common_work,
                       recipient_type: @common_work.class.name,
                           account_id: @account.id)
                           
      @common_work.update_completeness
      redirect_to_return_url account_account_common_work_path(@account, @common_work)
    else
      render :edit
    end
  end
  
  def recordings
    forbidden unless current_account_user.read_common_work
    @common_work    = CommonWork.cached_find(params[:id])
  end
  
  def recordings_new
    forbidden unless current_account_user.update_common_work
    forbidden unless current_account_user.create_recording
    @common_work    = CommonWork.cached_find(params[:id])
  end
  
  def recordings_create
    forbidden unless current_account_user.update_common_work
    forbidden unless current_account_user.create_recording?
    
    @common_work           = CommonWork.cached_find(params[:id])
    
    begin
      TransloaditParser.add_to_common_work params[:transloadit], @common_work.id, @account.id
      flash[:info]      = { title: "Success", body: "Recording added to Common Work" }
      redirect_to recordings_account_account_common_work_path(@account, @common_work )
    rescue
      flash[:danger]      = { title: "Unable to create Recording", body: "Please check if you selected a valid file" }
      redirect_to new_recordings_account_account_common_work_path(@account, @common_work )
    end

  end
  
  def destroy
    forbidden unless current_account_user.delete_common_work
    @common_work    = CommonWork.cached_find(params[:id])
    @common_work.destroy
    redirect_to account_account_common_works_path @account

  end
  
private
  
  def common_work_params
    params.require(:common_work).permit!
  end
  
  
end
