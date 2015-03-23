require 'rails_helper'

RSpec.describe "creative_project_users/index", :type => :view do
  before(:each) do
    assign(:creative_project_users, [
      CreativeProjectUser.create!(
        :creative_project => nil,
        :user => nil,
        :approved_by_project_manager => false,
        :approved_by_user => false,
        :locked => false,
        :email => "Email",
        :created_by => 1,
        :writers => false,
        :composers => false,
        :musicians => false,
        :dancers => false,
        :live_performers => false,
        :producers => false,
        :studio_facilities => false,
        :financial_services => false,
        :legal_services => false,
        :publishers => false,
        :remixers => false,
        :audio_engineers => false,
        :video_artists => false,
        :graphic_artists => false,
        :other => false
      ),
      CreativeProjectUser.create!(
        :creative_project => nil,
        :user => nil,
        :approved_by_project_manager => false,
        :approved_by_user => false,
        :locked => false,
        :email => "Email",
        :created_by => 1,
        :writers => false,
        :composers => false,
        :musicians => false,
        :dancers => false,
        :live_performers => false,
        :producers => false,
        :studio_facilities => false,
        :financial_services => false,
        :legal_services => false,
        :publishers => false,
        :remixers => false,
        :audio_engineers => false,
        :video_artists => false,
        :graphic_artists => false,
        :other => false
      )
    ])
  end

  it "renders a list of creative_project_users" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
