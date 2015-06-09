require 'rails_helper'

RSpec.describe "playlist_emails/show", type: :view do
  before(:each) do
    @playlist_email = assign(:playlist_email, PlaylistEmail.create!(
      :emails => "MyText",
      :title => "Title",
      :body => "MyText",
      :attach_files => false,
      :playlist => nil,
      :user => nil,
      :account => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
