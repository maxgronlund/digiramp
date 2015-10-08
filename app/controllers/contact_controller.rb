class ContactController < ApplicationController
  def index
    @contact = Contact.new()
  end
end
