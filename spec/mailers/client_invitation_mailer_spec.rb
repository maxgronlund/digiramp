require "rails_helper"

RSpec.describe ClientInvitationMailer, :type => :mailer do
  describe "send_with_avatar" do
    let(:mail) { ClientInvitationMailer.send_with_avatar }

    it "renders the headers" do
      expect(mail.subject).to eq("Send with avatar")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

  describe "send" do
    let(:mail) { ClientInvitationMailer.send }

    it "renders the headers" do
      expect(mail.subject).to eq("Send")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
