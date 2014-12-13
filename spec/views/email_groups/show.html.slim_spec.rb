require 'rails_helper'

RSpec.describe "email_groups/show", :type => :view do
  before(:each) do
    @email_group = assign(:email_group, EmailGroup.create!(
      :title => "Title",
      :body => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
  end
end
