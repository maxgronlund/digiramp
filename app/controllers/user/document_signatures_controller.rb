class User::DocumentSignaturesController < ApplicationController
  before_action :access_user
  before_action :set_document
  def index
    #@document = Document.cached_find(params[:legal_document_id])
  end
  
  def new
    #@document = Document.cached_find(params[:legal_document_id])
    @digital_signature = DigitalSignature.new
  end
  
  def create
    params[:digital_signature][:uuid] = UUIDTools::UUID.timestamp_create().to_s
    if user = User.get_by_email(params[:digital_signature][:email])
      params[:digital_signature][:user_id] = user.id 
    end
    if DigitalSignature.create(digital_signature_params)
      redirect_to user_user_legal_document_document_signatures_path(@user, @document.uuid)
    else
      render :new
    end
  end
  
  
  def edit
    @digital_signature = DigitalSignature.cached_find(params[:id])
  end
  
  def update
    @digital_signature = DigitalSignature.cached_find(params[:id])
    if @digital_signature.update(digital_signature_params)
      redirect_to user_user_legal_document_document_signatures_path(@user, @document.uuid)
    else
      render :edit
    end
  end
  
  def destroy
    digital_signature = DigitalSignature.cached_find(params[:id])
    digital_signature.destroy
    
    redirect_to user_user_legal_document_document_signatures_path(@user, @document.uuid)
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.cached_find(params[:legal_document_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def digital_signature_params
      params.require(:digital_signature).permit!
    end
    
end
