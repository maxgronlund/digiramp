class User::PublishingAgreementTemplatesController < ApplicationController
  before_action :access_user
  before_action :get_parrents
  
  def index
  end
  
  def show
    
    template = Document.cached_find(params[:id])
    doc = CopyMachine.copy_document( template )
    doc.update(
      template_id:          template.id,
      belongs_to_id:        @publishing_agreement.id,
      belongs_to_type:      @publishing_agreement.class.name,
      expires:              false
    )
    
    CopyMachine.create_document_users template, doc
    redirect_to user_user_publisher_publishing_agreement_path(@user, @publisher, @publishing_agreement)

  end
  
  
  private
  
  def get_parrents
    @publishing_agreement = PublishingAgreement.cached_find(params[:publishing_agreement_id])
    @publisher = Publisher.cached_find(params[:publisher_id])
    @documents = Document.templates.where(tag: 'Publishing')
  end
  
end
