class User::ImportContactsController < ApplicationController
  before_action :access_user
  include AccountsHelper
  
  def index
  end

  def create
  end
end
