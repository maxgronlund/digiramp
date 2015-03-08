class BecomeMembersController < ApplicationController
  def new
    @connect_to_user  = User.cached_find(params[:user])
  end
end
