class User::ContactGroupsController < ApplicationController
  
  before_filter :access_user
  include AccountsHelper
  before_filter :access_account
  
  
  def new
  end

  def update
  end

  def edit
  end

  def delete
  end

  def index
  end

  def show
  end
end
