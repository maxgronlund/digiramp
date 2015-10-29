class SignUpController < ApplicationController

  
  
private

  def user_params
    params.require('/sign_up').permit!
  end
end
