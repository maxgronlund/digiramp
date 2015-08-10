require 'rails_helper'

RSpec.describe "professional_infos/index", type: :view do
  before(:each) do
    assign(:professional_infos, [
      ProfessionalInfo.create!(
        :ipi_code => "Ipi Code"
      ),
      ProfessionalInfo.create!(
        :ipi_code => "Ipi Code"
      )
    ])
  end

  it "renders a list of professional_infos" do
    render
    assert_select "tr>td", :text => "Ipi Code".to_s, :count => 2
  end
end
