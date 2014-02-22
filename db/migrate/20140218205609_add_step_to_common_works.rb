class AddStepToCommonWorks < ActiveRecord::Migration
  def change
    add_column :common_works, :step, :string, default: 'created'
    
    CommonWork.all.each do |common_work|
      common_work.step = 'completed'
      common_work.save!
    end
  end
end
