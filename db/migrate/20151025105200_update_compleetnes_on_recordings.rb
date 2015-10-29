class UpdateCompleetnesOnRecordings < ActiveRecord::Migration
  def change
    CommonWork.find_each do |common_work|
      common_work.save
    end
  end
end
