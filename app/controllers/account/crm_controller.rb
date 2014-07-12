class Account::CrmController < ApplicationController
  include AccountsHelper
  before_filter :access_account
  
  def index
  end
end
