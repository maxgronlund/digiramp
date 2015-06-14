class MailMessage < ActiveRecord::Base
  #attr_accessible :body, :identifier, :subject
  def self.representative_invitation; MailMessage.where(identifier: 'Representative Invitation').first_or_create(identifier: 'Representative Invitation', subject: 'Representative Invitation' ) end
  def self.signup_confirmation; MailMessage.where(identifier: 'Signup Confirmation').first_or_create(identifier: 'Signup Confirmation', subject: 'Signup Confirmation' ) end
  def self.contact_confirmation_mail; MailMessage.where(identifier: 'Contact Confirmation Mail').first_or_create(identifier: 'Contact Confirmation Mail', subject: 'Your contact request has been received' ) end
  #def self.password_reset; MailMessage.where(identifier: 'Password Reset').first_or_create(identifier: 'Password Reset', subject: 'Password Reset' ) end
  def self.account_invitation; MailMessage.where(identifier: 'Account invitation').first_or_create(identifier: 'Account invitation', subject: 'Account invitation' ) end
  def self.new_account_and_user_confirmation; MailMessage.where(identifier: 'New account and user created').first_or_create(identifier: 'New account and user created', subject: 'You have been signed up for an account at DigiRAMP' ) end
  
  
  
  
end


