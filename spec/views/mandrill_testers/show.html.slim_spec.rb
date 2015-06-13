require 'rails_helper'

RSpec.describe "mandrill_testers/show", type: :view do
  before(:each) do
    @mandrill_tester = assign(:mandrill_tester, MandrillTester.create!(
      :email => "Email",
      :subject => "Subject",
      :message => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Subject/)
    expect(rendered).to match(/MyText/)
  end
end
