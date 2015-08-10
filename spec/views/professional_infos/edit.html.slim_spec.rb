require 'rails_helper'

RSpec.describe "professional_infos/edit", type: :view do
  before(:each) do
    @professional_info = assign(:professional_info, ProfessionalInfo.create!(
      :ipi_code => "MyString"
    ))
  end

  it "renders the edit professional_info form" do
    render

    assert_select "form[action=?][method=?]", professional_info_path(@professional_info), "post" do

      assert_select "input#professional_info_ipi_code[name=?]", "professional_info[ipi_code]"
    end
  end
end
