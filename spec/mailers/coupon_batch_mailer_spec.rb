require "rails_helper"

RSpec.describe CouponBatchMailer, :type => :mailer do
  describe "send_coupon" do
    let(:mail) { CouponBatchMailer.send_coupon }

    it "renders the headers" do
      expect(mail.subject).to eq("Send coupon")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

  describe "batch_ready" do
    let(:mail) { CouponBatchMailer.batch_ready }

    it "renders the headers" do
      expect(mail.subject).to eq("Batch ready")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
