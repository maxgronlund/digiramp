class User::PublishingAgreementUsersController < ApplicationController
  before_action :access_user
  
  def index
    redirect_to :back
  end

  def new

    @publisher = Publisher.cached_find(params[:publisher_id])
    @publishing_agreement = PublishingAgreement.cached_find(params[:publishing_agreement_id])
    @document             = @publishing_agreement.document
    @document_user        = DocumentUser.new(document_id: @document.id)

  end

  def create
    @publishing_agreement = PublishingAgreement.cached_find(params[:publishing_agreement_id])
    @publisher            = Publisher.cached_find(params[:publisher_id])
    @document_user        = DocumentUser.create(document_user_params)
    
    if @document_user.should_sign
      DigitalSignature.create(
        signable_id: @publishing_agreement.document_id,
        signable_type: 'Document',
        role: @document_user.role,
        email: @document_user.email

      )
    end
    
    redirect_to user_user_publisher_publishing_agreement_path(@user, @publisher, @publishing_agreement)


  end

  def edit
    @publisher = Publisher.cached_find(params[:publisher_id])
    @publishing_agreement = PublishingAgreement.cached_find(params[:publishing_agreement_id])
    @document             = @publishing_agreement.document
    @document_user        = DocumentUser.cached_find(params[:id])
  end

  def update
    redirect_to :back
  end

  def destroy
    redirect_to :back
  end
  
  private  
  
  def document_user_params
    params.require(:document_user).permit!
  end
end
