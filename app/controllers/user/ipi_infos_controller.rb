class User::IpiInfosController < ApplicationController
  before_filter :access_user
  def show
    @ipi = Ipi.cached_find(params[:id])
  end
end
