class User::DistributionAgreementTemplatesController < ApplicationController
  
  before_action :access_user
  before_action :get_parrents
  
  def index
    
  end
  
  def show
    ap params
    template = Document.cached_find(params[:id])
    
    doc = CopyMachine.copy_document( template )
    doc.update(
      template_id:          template.id,
      belongs_to_id:        @distribution_agreement.id,
      belongs_to_type:      @distribution_agreement.class.name,
      expires:              false
    )
    
    CopyMachine.create_document_users template, doc
    
    
    
    
    redirect_to user_user_label_distribution_agreement_path(@user, @label, @distribution_agreement)
   
  end
  
  private
  
  def get_parrents
    @distribution_agreement = DistributionAgreement.cached_find(params[:distribution_agreement_id])
    @label = Label.cached_find(params[:label_id])
    @documents = Document.templates.where(tag: 'Distribution')
  end
  
  
end
