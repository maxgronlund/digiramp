class SnsMessagesController < ApplicationController
  
  protect_from_forgery only: :receive
  def receive
    # params
    render nothing: true
  end
end
