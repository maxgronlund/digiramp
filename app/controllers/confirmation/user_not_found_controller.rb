class Confirmation::UserNotFoundController < ApplicationController
  def index
    @ipi    = Ipi.where(uuid: params[:uuid]).first
  end
end
