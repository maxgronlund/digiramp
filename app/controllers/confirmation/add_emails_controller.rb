class Confirmation::AddEmailsController < ApplicationController
  def new

    forbidden unless current_user
    if @ipi = Ipi.where(uuid: params[:uuid]).first 
      UserEmail.create(email: @ipi.email, user_id: current_user.id)
      @ipi.user_id = current_user.id
      @ipi.confirmation = 'Confirmed'
      @ipi.save!
      redirect_to user_user_ipi_path(current_user, @ipi)
    else
      redirect_to :back
    end
    
  end
end
