class Admin::BusinessController < ApplicationController
  before_action :admin_only
  def index
    #@user       = current_user
  end
end
