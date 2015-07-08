class DigitalSignature < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :image
  
  mount_uploader :image, SignatureUploader
end
