class User::IpiPublishingAgreementsController < ApplicationController
  def create
    ap params
    redirect_to :back
    ipi_publishing_agreement = IpiPublishingAgreement.create(ipi_publishing_agreement_params)
    if ipi = ipi_publishing_agreement.ipi
      ipi.update(i_am_the_publishing_designee: true,
                 confirmation: 'Confirmed',
                )
      ipi.accepted!
    end
    
  end
  
  private
  
  def ipi_publishing_agreement_params
    params.require(:ipi_publishing_agreement).permit!
    
  end
end
