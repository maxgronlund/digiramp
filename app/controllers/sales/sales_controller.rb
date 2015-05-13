class Sales::SalesController < ApplicationController
  before_action :permit_salesperson
  
  
  def permit_salesperson
    @user = current_user
    return if current_user && current_user.salesperson
    return if super?
    forbidden
  end
  
end
