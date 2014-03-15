class UploadsController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
  
  def new
  end

  def create
    
    #Rails.logger.info("PARAMS: #{params[:transloadit].inspect}")
    
    @upload = Upload.new(audio_upload: params[:transloadit])
    @upload.save!
    
    redirect_to upload_path @upload
  end
  
  def show
    @upload = Upload.find(params[:id])
    
  end
  

  #def transloadit_params
  #  #if current_user.can_administrate( @account)
  #    params.require(:transloadit).permit!
  #    #end
  #end
end
