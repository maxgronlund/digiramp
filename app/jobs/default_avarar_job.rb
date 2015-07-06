class DefaultAvararJob < ActiveJob::Base
  queue_as :default

  # add a default avatar to the user
  def perform user_id
    
    return unless Rails.env.production?
    
    user = User.cached_find(user_id)
    ActiveRecord::Base.connection_pool.with_connection do
    
      prng       = Random.new
      random_id =  prng.rand(85)

      if random_id < 10
        random_id = '0' + random_id.to_s 
      end
      user.remote_image_url = "https://s3-us-west-1.amazonaws.com/digiramp/uploads/default-avatars/5GA3Zk1C_avatar_#{random_id.to_s}.jpg"
      user.save!
    end
  end
end


