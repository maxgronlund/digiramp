class AssetsController < ApplicationController
  before_filter :there_is_access_to_the_account
  def index
  end
end
