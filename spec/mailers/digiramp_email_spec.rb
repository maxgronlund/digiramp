require "rails_helper"

RSpec.describe DigirampEmail, :type => :mailer do
  describe "news_email" do
    let(:mail) { DigirampEmail.news_email }

    it "renders the headers" do
      expect(mail.subject).to eq("News email")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
