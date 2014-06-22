class User::CatalogsController < ApplicationController
  
  before_filter :access_user, only: [:show, :edit, :update, :destroy, :index]

  
  def index
    
  end

  
end
