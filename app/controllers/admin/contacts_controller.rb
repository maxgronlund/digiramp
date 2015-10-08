class Admin::ContactsController < ApplicationController
  before_action :editor_only
  def index
    @contacts = Contact.where(contact_subject: "contact").order(:created_at)
  end

  def show
  end
end
