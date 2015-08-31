class User::IpiPublishersController < ApplicationController
  before_action :access_user


  
  def show
  end

  def new

    @common_work  = CommonWork.cached_find(params[:common_work_id])
    @ipi          = Ipi.cached_find(params[:ipi_id])
    
    
    if user = @ipi.user
      @documents    = user.get_publishing_agreements
    else
      @documents = []
    end
    
    if document_id =  params[:document_id]
      @document = Document.cached_find(document_id)
      if publishing_agreement = PublishingAgreement.find_by(document_id: @document.uuid)
        IpiPublishingAgreement.where( ipi_id: @ipi.id,
                                      publishing_agreement_id: publishing_agreement.id)
                    .first_or_create( ipi_id: @ipi.id, 
                                      publishing_agreement_id: publishing_agreement.id)
      end
      
      redirect_to user_user_common_work_ipi_path(@user, @common_work, @ipi)
    end
    
  end

  def create
  end

  def update
  end

  def destroy
  end
end
