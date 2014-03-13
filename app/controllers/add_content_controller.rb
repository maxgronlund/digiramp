class AddContentController < ApplicationController
  before_filter :there_is_access_to_the_account
  
  def index
    if current_user.can_manage 'add_music', @account
      
    else
      render :file => "#{Rails.root}/public/422.html", :status => 422, :layout => false
    end
  end
end
