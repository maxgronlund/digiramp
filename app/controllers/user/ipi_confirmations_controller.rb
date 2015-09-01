class User::IpiConfirmationsController < ApplicationController
  before_action :access_user
  def update
    @ipi = Ipi.cached_find(params[:id])
    @ipi.accepted!
  end
end
