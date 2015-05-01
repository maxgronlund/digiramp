class SharedCommonWorkIpisController < ApplicationController
  
  include SharedCommonWorkIpisHelper
  before_action :access_user
  before_action :read_common_work_ipis, only:[:index]
  
  def show
  end

  def index
  end

  def edit
  end

  def new
  end
end
