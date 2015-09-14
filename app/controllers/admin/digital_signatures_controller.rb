class Admin::DigitalSignaturesController < ApplicationController
  
  def create

    @digital_signature = DigitalSignature.new(digital_signature_params)
    
    case params[:commit]
      
    when 'Save and exit'
      @digital_signature.save(validate: false)
      
      redirect_to admin_legal_templates_path
    when 'Save and add next'
      @digital_signature.save(validate: false)
      redirect_to admin_legal_template_path(@digital_signature.signable.uuid)
    when 'Cancel'
      redirect_to admin_legal_templates_path
    end
      
  end
  
 
  
  def destroy

    @digital_signature = DigitalSignature.cached_find(params[:id])
    uuid = @digital_signature.signable.uuid
    @digital_signature.destroy
    redirect_to admin_legal_template_path(uuid)
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_digital_signature
      @digital_signature = DigitalSignature.cached_find(params[:id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def digital_signature_params
      params.require(:digital_signature).permit(:uuid, 
                                                :user_id, 
                                                :image,
                                                :role,
                                                :signable_type,
                                                :signable_id)
    end
end
