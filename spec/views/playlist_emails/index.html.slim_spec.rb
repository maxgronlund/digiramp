require 'rails_helper'

RSpec.describe "playlist_emails/index", type: :view do
  before(:each) do
    assign(:playlist_emails, [
      PlaylistEmail.create!(
        :emails => "MyText",
        :title => "Title",
        :body => "MyText",
        :attach_files => false,
        :playlist => nil,
        :user => nil,
        :account => nil
      ),
      PlaylistEmail.create!(
        :emails => "MyText",
        :title => "Title",
        :body => "MyText",
        :attach_files => false,
        :playlist => nil,
        :user => nil,
        :account => nil
      )
    ])
  end

  it "renders a list of playlist_emails" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
