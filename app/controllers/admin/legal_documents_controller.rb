class Admin::LegalDocumentsController < ApplicationController
  before_filter :admin_only
  def index
  end
end
