class AssetsController < ApplicationController
  include AccountsHelper
  before_action :access_account
  def index
  end
end
