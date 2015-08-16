class Account::PublishersController < ApplicationController
  include AccountsHelper
  before_action :access_account
  def index
    @publishers = @account.publishers
    @user = current_user
  end
end
