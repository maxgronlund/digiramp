require 'rails_helper'

RSpec.describe "professional_infos/show", type: :view do
  before(:each) do
    @professional_info = assign(:professional_info, ProfessionalInfo.create!(
      :ipi_code => "Ipi Code"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Ipi Code/)
  end
end
