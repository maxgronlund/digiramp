require 'rails_helper'

RSpec.describe "professional_infos/new", type: :view do
  before(:each) do
    assign(:professional_info, ProfessionalInfo.new(
      :ipi_code => "MyString"
    ))
  end

  it "renders new professional_info form" do
    render

    assert_select "form[action=?][method=?]", professional_infos_path, "post" do

      assert_select "input#professional_info_ipi_code[name=?]", "professional_info[ipi_code]"
    end
  end
end
