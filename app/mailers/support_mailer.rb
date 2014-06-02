class SupportMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.support_mailer.ticket_created.subject
  #
  def ticket_created
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.support_mailer.comment_posted.subject
  #
  def comment_posted
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.support_mailer.issue_closed.subject
  #
  def issue_closed
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
