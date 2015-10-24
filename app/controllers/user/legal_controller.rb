class User::LegalController < ApplicationController
  before_action :access_user
  def index
    #@publishers = Publisher.where(user_id: @user.id, personal_publisher: true)
  end
end
