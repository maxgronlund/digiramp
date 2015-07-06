class Admin::LegalTemplatesController < ApplicationController
  before_action :admins_only
  
  def index
    @documents   = Document.templates
    @system_user = User.system_user
    @account     = @system_user.account
  end

  def show
  end

  def new
    @document      = Document.new
    @system_user   = User.system_user
    @account       = @system_user.account
  end

  def edit
  end
end
