class User::AcceptIpisController < ApplicationController
  before_filter :access_user
  def update
    ap params

    @ipi = Ipi.cached_find(params[:id])
    @ipi.confirmation = 'Accepted'
    @ipi.save!
    redirect_to user_user_ipi_path(@user, @ipi)
  end
end
