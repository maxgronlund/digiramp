class AttachmentsController < ApplicationController
  include AccountsHelper
  before_action :access_to_account
  
  def new
    #account_id"=>"6", "common_work_id
    @file_type          = params[:file_type]
    if params[:common_work_id]
      @attachable       = CommonWork.cached_find(params[:common_work_id])
      @attachment       = Attachment.new()
      @back             = account_work_path( @account, @attachable)
    else
      redirect_to :back
    end
  end
  
  def create
    
    @attachable = Attachment.create(attachment_params)
    case @attachable.attachable_type
      
    when 'CommonWork'
      @common_work    = CommonWork.cached_find(params[:common_work_id])
      redirect_to account_work_path(@account, @common_work)
    end
  end

  def edit
    @attachment = Attachment.find(params[:id])
    if params[:common_work_id]
      @attachable       = CommonWork.cached_find(params[:common_work_id])
      @back             = account_work_path( @account, @attachable)
      @file_type        = @attachment.file_type
    else
      redirect_to :back
    end
  end
  
  def update
    @attachment = Attachment.find(params[:id])
    @attachment.update_attributes(attachment_params)
    case @attachment.attachable_type
    when 'CommonWork'
      @common_work    = CommonWork.cached_find(params[:common_work_id])
      redirect_to account_work_path(@account, @common_work)
    end
  end
  
  def destroy
    @attachment    = Attachment.find(params[:id]) 
    
    if params[:common_work_id]
      @common_work   = CommonWork.cached_find(params[:common_work_id])
      @attachment.destroy
      redirect_to account_work_path(@account, @common_work)
    end
  end
  
  def download
    begin
      @attachment = Attachment.find(params[:id])
      @file_name  = Pathname.new(@attachment.file_url).basename 
      send_file 'public'+ @attachment.file_url.to_s
    rescue
      redirect_to :back
    end
  end
  
  
private  

  def attachment_params
     params.require(:attachment).permit!
  end
  

end
