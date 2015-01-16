class User::ImportContactsController < ApplicationController
  before_filter :access_user
  include AccountsHelper
  
  def index
  end

  def create
  end
end
