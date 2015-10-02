class User::PublishingAgreementDocumentsController < ApplicationController
  before_action :access_user
  
  def new
    
    @publisher            = Publisher.cached_find(params[:publisher_id])
    @publishing_agreement = PublishingAgreement.find(params[:publishing_agreement_id])
  end

  def create
    @publisher               = Publisher.cached_find(params[:publisher_id])
    @publishing_agreement    = PublishingAgreement.find(params[:publishing_agreement_id])
    
    params[:document][:uuid]              =      UUIDTools::UUID.timestamp_create().to_s
    params[:document][:body]              =      'Uploaded document'
    params[:document][:text_content]      =      'Uploaded document'
    params[:document][:tag]               =      'PublishingAgreement'
    params[:document][:document_type]     =      'Legal'
    params[:document][:belongs_to_type]   =      'PublishingAgreement'
    params[:document][:belongs_to_id]     =      @publishing_agreement.id
    
    
    
    if @document = Document.create(document_params)
      redirect_to user_user_publisher_publishing_agreement_path(@user, @publisher, @publishing_agreement)
    else
      render :new
    end
  end

  def destroy
  end
  
  private
  
  def document_params
    params.require(:document).permit!#( :title, 
                                     # :document_type, 
                                     # :body, 
                                     # :file, 
                                     # :usage, 
                                     # :account_id, 
                                     # :text_content,
                                     # :template_id,
                                     # :tag,
                                     # :uuid,
                                     # :status) 
    
  end
end
