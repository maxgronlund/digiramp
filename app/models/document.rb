class Document < ActiveRecord::Base
  belongs_to :account
  
  TYPES = ['Legal', 'Financial', 'File']
end
