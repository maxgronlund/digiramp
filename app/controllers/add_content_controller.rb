class AddContentController < ApplicationController
  include AccountsHelper
  before_filter :access_account
  
  def index
    forbidden unless current_account_user.can_add_content?
  end
end
