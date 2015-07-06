class User::LegalController < ApplicationController
  before_action :access_user
  def index
  end
end
