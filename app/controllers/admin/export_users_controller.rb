class Admin::ExportUsersController < ApplicationController
  before_filter :admin_only
  
  def index
    @users = User.order(:name)
    respond_to do |format|
      format.html
      format.csv { render text: @users.to_csv }
    end
  end
end
