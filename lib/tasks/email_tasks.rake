# file: lib/tasks/email_tasks.rake
 
desc 'send digest email'
task send_digest_email: :environment do
  # ... set options if any
  UserMailer.digest_email_update(options).deliver!
end