require 'test_helper'

class SupportMailerTest < ActionMailer::TestCase
  test "ticket_created" do
    mail = SupportMailer.ticket_created
    assert_equal "Ticket created", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "comment_posted" do
    mail = SupportMailer.comment_posted
    assert_equal "Comment posted", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "issue_closed" do
    mail = SupportMailer.issue_closed
    assert_equal "Issue closed", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
