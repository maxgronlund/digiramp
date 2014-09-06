require 'rails_helper'

RSpec.describe "fobars/show", :type => :view do
  before(:each) do
    @fobar = assign(:fobar, Fobar.create!(
      :index => "Index"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Index/)
  end
end
