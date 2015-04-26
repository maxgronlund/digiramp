class Admin::BusinessController < ApplicationController
  before_filter :admin_only
  def index
    #@user       = current_user
  end
end
