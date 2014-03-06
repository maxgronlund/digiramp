class Admin::AdministratorsController < ApplicationController
  def index
    @admins = User.where(role: 'super')
  end

  def edit
  end

  def update
  end

  def delete
  end

  def new
  end
end
