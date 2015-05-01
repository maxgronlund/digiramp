class Admin::EmailsController < ApplicationController
  before_action :admin_only
  def index
    @emails = Email.order('created_at desc')
    
  end

  def show
    @email = Email.cached_find(params[:id])
  end
end
