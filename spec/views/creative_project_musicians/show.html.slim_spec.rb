require 'rails_helper'

RSpec.describe "creative_project_roles/show", :type => :view do
  before(:each) do
    @creative_project_role = assign(:creative_project_role, CreativeProjectRole.create!(
      :creative_project => nil,
      :creative_project_user => nil,
      :instrument => "Instrument",
      :other_instrument => "Other Instrument"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Instrument/)
    expect(rendered).to match(/Other Instrument/)
  end
end
