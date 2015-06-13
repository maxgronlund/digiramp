# Preview all emails at http://localhost:3000/rails/mailers/mandrill_mailer
class MandrillMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/mandrill_mailer/send_test
  def send_test
    MandrillMailer.send_test
  end

end
