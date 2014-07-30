class Contact < ActiveRecord::Base
  
  validates :email, :title, :body, presence: true
end
