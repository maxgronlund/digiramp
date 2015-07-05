class DigitalSignature < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  belongs_to :document, polymorphic: true
end
