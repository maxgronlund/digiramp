class DigirampEmail < ActiveRecord::Base
  belongs_to :email_group
  
  LAYOUT = {'News mail' => 'news_email'}
  
  mount_uploader :image_1, DigirampEmailUploader
end


