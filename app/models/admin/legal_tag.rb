class Admin::LegalTag < ActiveRecord::Base
  validates :title, :body, presence: true, uniqueness: true
  
  
end



