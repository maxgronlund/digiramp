require 'rails_helper'

RSpec.describe "creative_project_users/show", :type => :view do
  before(:each) do
    @creative_project_user = assign(:creative_project_user, CreativeProjectUser.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
  end
end
