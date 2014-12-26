class DisqusController < ApplicationController
  def index
    @user = current_user if current_user
  end
end
