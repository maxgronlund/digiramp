class Admin::ContentController < ApplicationController
  before_action :editor_only

  def index
    
  end
end