require "rails_helper"

RSpec.describe Ipi, :type => :mailer do
  describe "confirm_recording" do
    let(:mail) { Ipi.confirm_recording }

    it "renders the headers" do
      expect(mail.subject).to eq("Confirm recording")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

  describe "confirm_common_work" do
    let(:mail) { Ipi.confirm_common_work }

    it "renders the headers" do
      expect(mail.subject).to eq("Confirm common work")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
