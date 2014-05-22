class AssetsController < ApplicationController
  include AccountsHelper
  before_filter :access_to_account
  def index
  end
end
