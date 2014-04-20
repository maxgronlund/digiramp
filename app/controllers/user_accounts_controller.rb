class UserAccountsController < ApplicationController
  before_filter :access_user
  def index

  end
end
