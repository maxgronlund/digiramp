class AddCompletenessToCommonWorks < ActiveRecord::Migration
  def change
    add_column :common_works, :completeness, :decimal
    
    CommonWork.all.each do |common_work|
      common_work.update_completeness
    end
  end
end
