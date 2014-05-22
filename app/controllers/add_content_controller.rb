class AddContentController < ApplicationController
  include AccountsHelper
  before_filter :access_to_account
  
  def index
    if current_user.can_manage 'add_music', @account
      
    else
      render :file => "#{Rails.root}/public/422.html", :status => 422, :layout => false
    end
  end
end
