module KnowRecordingsHelper

  def find_or_create_recording  user, title
    return @recording if @recording = recording_with_title( title )

    @recording       = FactoryGirl.create(:recording, title: title, user_id: user.id, account_id: user.account.id)
    
    common_work = CommonWork.create(account_id: @recording.account_id, 
                                    title:      @recording.title, 
                                    lyrics:     @recording.lyrics)
    
    
  end
  
  def recording_with_title title
    Recording.find_by(title: title)
  end
  
 
  
  #def create_user role, first_name, last_name , email, password, super_user
  #  user = User.new()
  #  user.first_name = first_name
  #  user.last_name  = last_name
  #  user.role       = role
  #  
  #  user.super_user = super_user
  #  user.save  validate: false
  #  user.profile = MemberProfile.new email: email, password: password, password_confirmation: password
  #  user.email      = email
  #  user.profile.save!
  #  user.save  validate: false
  #end
  
end

World(KnowRecordingsHelper)