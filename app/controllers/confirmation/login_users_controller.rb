class Confirmation::LoginUsersController < ApplicationController
  def show
    @ipi  = Ipi.where(uuid: params[:uuid]).first
    session[:current_page] = url_for( controller: 'confirmation/ipi_confirmations', action: 'show', id: @ipi.uuid )
  end
end
