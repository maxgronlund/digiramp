class ConnectionDigalogsController < ApplicationController
  def new
    @recipient  = User.cached_find(params[:receiver])
    @sender     = User.cached_find(params[:sender])
    @connection = Connection.new(message: "Hi #{@recipient.user_name } \r\nI'd like to add you to my connections \r\n\n --#{@sender.user_name}")
  end

end
