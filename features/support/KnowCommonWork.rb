module KnowCommonWorkHelper

  def create_common_works common_works_table
    common_works_table[1 .. common_works_table.length].each do |common_work_row|
      
      work_title    = common_work_row[0]
      account_title = common_work_row[1]
      account       = Account.where(title: account_title).first
    
      CommonWork.create(title: work_title, account_id: account.id).title
    end
  end
  
end

World(KnowCommonWorkHelper)