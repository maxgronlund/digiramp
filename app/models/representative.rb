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
      account = Account.create( title: User.create_uniq_user_name_from_email(self.email), 
                                account_type: 'representative', 
                                contact_email: self.email,
                                user_id: self.user_id,
                                expiration_date: Date.current + 6.months)
      
      created_user = account.users.create( email: self.email, 
                                           password: password, 
                                           role: 'representative',
                                           account_id: account.id)
      account.user_id = created_user.id
      account.save!
      self.user_id = created_user.id
      self.new_user = true;
      save!
    end
  end
  

  
  
end
