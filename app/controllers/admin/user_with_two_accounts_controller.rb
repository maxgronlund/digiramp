class Admin::UserWithTwoAccountsController < ApplicationController
  before_action :admin_only
  def index
    @users = []
    User.find_each do |user|
      accounts = Account.where(user_id: user.id)
      if accounts.count > 1
        @users << {user: user, accounts: accounts}

      end
    end
  end
end
