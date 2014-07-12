class Project < ActiveRecord::Base
  belongs_to :account
  belongs_to :user
  
  STAGES = ["Planning", "Started", "Running", "Evaluation", "Closed"]
  CATEGORIES = ["Sales", "Acquisition", "Promotion", "Collaboration", "Invitation", "Request", "Other"]
end
