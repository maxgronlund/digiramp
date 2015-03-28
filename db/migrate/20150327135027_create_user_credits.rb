class CreateUserCredits < ActiveRecord::Migration
  def change
    create_table :user_credits do |t|
      t.belongs_to :user, index: true
      t.references :ipiable, polymorphic: true, index: true
      t.string :title
      t.timestamps null: false
    end
  
  
    # attach credits
    #User.find_each do |user|
    #  user.recordings.each do |recording|
    #    UserCredit.create(title: recording.title, user_id: user.id, ipiable_id: recording.id, ipiable_type: recording.class.name)
    #  end
    #
    #  user.account.common_works.each do |common_work|
    #    UserCredit.create(title: common_work.title, user_id: user.id, ipiable_id: common_work.id, ipiable_type: common_work.class.name)
    #  end
    #end
    
    # common_works
    Ipi.find_each do |ipi|
      
      UserCredit.create(title: ipi.common_work.title, user_id: ipi.user_id, ipiable_id: ipi.id, ipiable_type: ipi.class.name)
    end
    # recordings
    RecordingIpi.find_each do |recording_ipi|
      UserCredit.create(title: recording_ipi.recording.title, user_id: recording_ipi.user_id, ipiable_id: recording_ipi.id, ipiable_type: recording_ipi.class.name)
    end
  
  end
end

