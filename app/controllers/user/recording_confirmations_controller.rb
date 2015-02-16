class User::RecordingConfirmationsController < ApplicationController
  def update
    
    ap params
    @recording_ipi = RecordingIpi.cached_find(params[:recording][:recording_ipi_id])
    
    case params[:commit]
      
    when 'Request confirmation'
      @recording_ipi.confirmation = 'pending'
      @render = 'user/recording_confirmations/pending'
      
      # send confirmatiion email
    
    when 'Cancel'
      @recording_ipi.confirmation = 'missing'
      @render = 'user/recording_confirmations/missing'
    else
      ap 'bar'
    end
    
    #@recording_ipi.save!

  end
end
