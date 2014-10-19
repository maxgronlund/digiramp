class FixBrokenRecordings < ActiveRecord::Migration
  def change
    error_count = 0
    Recording.where(user_id: nil).find_each do |rec|
      
      begin
        rec.destroy
      rescue
        error_count += 1
      end
    end

    puts '-----------------'
    puts error_count
  end
end
