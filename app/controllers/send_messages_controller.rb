class SendMessagesController < ApplicationController
  
  before_filter :access_user, only: [:index]

  def index
    @authorized = true 
  end
  
end
