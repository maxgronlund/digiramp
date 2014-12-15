class Admin::SystemEmailsController < ApplicationController
  before_filter :admin_only
  def index
  end
end
