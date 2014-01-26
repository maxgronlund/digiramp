class Representative < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  
  after_create :check_if_there_is_an_account_for_the_representative
  
  def check_if_there_is_an_account_for_the_representative
    
    if User.exists?(email: self.email)
      self.user_id = User.where(email: self.email).first.id
      self.new_user = false;
      save!
    else

      password = ('0'..'z').to_a.shuffle.first(8).join
      account = Account.create( title: self.email, account_type: 'representative', contact_email: self.email)
      created_user = account.users.create(email: self.email, password: password, role: 'representative', name: self.email, account_id: account.id)
      account.user_id = created_user.id
      account.save!
      self.user_id = created_user.id
      self.new_user = true;
      save!
    end
  end
  

  
  
end
