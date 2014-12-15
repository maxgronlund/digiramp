require 'rails_helper'

RSpec.describe "digiramp_emails/show", :type => :view do
  before(:each) do
    @digiramp_email = assign(:digiramp_email, DigirampEmail.create!(
      :email_group => nil,
      :email_layout => nil,
      :title => "Title",
      :body => "MyText",
      :recipients => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end
