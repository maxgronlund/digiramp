class OpportunityMailer < ActionMailer::Base
  default from: "info@digiramp.com"

  def invite 
    
    mail to: 'max@pixelsonrails.com',  subject: 'test'
    puts '----------- invite --------------'
  end
end
