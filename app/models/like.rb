class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :recording
  belongs_to :account
  
  after_create :update_user
  after_destroy :update_user
  
  private
  
    def update_user
      user.update(likings: user.likes) 
    end
end
