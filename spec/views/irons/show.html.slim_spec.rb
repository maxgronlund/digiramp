require 'rails_helper'

RSpec.describe "irons/show", :type => :view do
  before(:each) do
    @iron = assign(:iron, Iron.create!(
      :title => "Title"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
  end
end
