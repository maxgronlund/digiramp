class SupportController < ApplicationController
  def index
    forbidden unless current_user
    @user = current_user
  end
end
