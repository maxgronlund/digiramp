module KnowAccountUsersHelper


  def add_customers_to_account customers_table
    customers_table.each do |customer_row|
      account = Account.where(title: customer_row[0]).first
      
      user    = User.where(email: customer_row[1]).first
      AccountUser.create( account_id: account.id, 
                          user_id: user.id, 
                          role: customer_row[3]
                          )
    end
  end
  
  def create_associate_users associate_users_table
    
    associate_users_table.each do |associate_user_row|
      
      account = Account.where(title: associate_user_row[0]).first
      user    = User.where(   email: associate_user_row[1]).first
      
      
      access_recordings   = associate_user_row[3] == "access_recordings"
      access_works        = associate_user_row[4] == "access_works"
      access_rights       = associate_user_row[5] == "access_rights"
      access_documents    = associate_user_row[6] == "access_documents"
      access_collect      = associate_user_row[7] == "access_collect"
      

      AccountUser.create( account_id: account.id,
                          user_id: user.id,
                          role: associate_user_row[2],
                          access_to_all_recordings: access_recordings,
                          access_to_all_common_works: access_works,
                          access_to_all_rights: access_rights,
                          access_to_all_documents: access_documents,
                          access_to_collect: access_collect
                          )

    end
    
    
  end
  
  
end

World(KnowAccountUsersHelper)


#access_to_all_recordings",   default: false
#access_to_all_common_works", default: false
#access_to_all_rights",       default: false
#access_to_all_documents",    default: false
#access_to_collect",          default: false
#version",                    default: 0