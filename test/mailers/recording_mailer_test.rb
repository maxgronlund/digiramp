require 'test_helper'

class RecordingMailerTest < ActionMailer::TestCase
  test "send_attachement" do
    mail = RecordingMailer.send_attachement
    assert_equal "Send attachement", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
