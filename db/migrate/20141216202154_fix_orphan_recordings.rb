class FixOrphanRecordings < ActiveRecord::Migration
  def change
    
    add_column :recordings, :orphan, :boolean, default: false
    orphants     = 0
    Recording.find_each do |recording|
      
      user          = recording.user
      account       = recording.account
      
      
        
      if user.nil? && account && account.user
        # user is missing
        recording.user_id = account.user.id
        recording.save
      elsif user.nil? && account.nil?
        # hmmm hard to handle
        recording.orphan = true
        recording.save
        puts '.'
        orphants += 1
        recording.destroy
      elsif user.nil? && account.user.nil?

        recording.orphan = true
        recording.save
        puts '.'
        orphants += 1
        recording.destroy

      end
    end

  end
end
