require "rails_helper"

RSpec.describe MandrillMailer, type: :mailer do
  describe "send_test" do
    let(:mail) { MandrillMailer.send_test }

    it "renders the headers" do
      expect(mail.subject).to eq("Send test")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
