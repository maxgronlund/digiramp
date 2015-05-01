class User::IpiInfosController < ApplicationController
  before_action :access_user
  def show
    @ipi = Ipi.cached_find(params[:id])
  end
end
