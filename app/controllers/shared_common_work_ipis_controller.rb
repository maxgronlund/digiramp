class SharedCommonWorkIpisController < ApplicationController
  
  include SharedCommonWorkIpisHelper
  before_filter :access_user
  before_filter :read_common_work_ipis, only:[:index]
  
  def show
  end

  def index
  end

  def edit
  end

  def new
  end
end
