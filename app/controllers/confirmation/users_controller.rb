class Confirmation::UsersController < ApplicationController
  def new
    @ipi = Ipi.where(uuid: params[:uuid]).first
  end
end
