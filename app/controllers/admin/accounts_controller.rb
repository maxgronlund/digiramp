class Admin::AccountsController < ApplicationController
  def index
    @accounts = Account.order('lower(title) ASC')
  end
end
