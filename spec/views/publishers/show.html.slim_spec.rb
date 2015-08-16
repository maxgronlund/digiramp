require 'rails_helper'

RSpec.describe "publishers/show", type: :view do
  before(:each) do
    @publisher = assign(:publisher, Publisher.create!(
      :user => "",
      :email, => "Email,",
      :phone_number, => "Phone Number,",
      :ipi_code, => "Ipi Code,",
      :cae_code => "Cae Code",
      :uuid => "",
      :pro_affiliation => "",
      :status => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Email,/)
    expect(rendered).to match(/Phone Number,/)
    expect(rendered).to match(/Ipi Code,/)
    expect(rendered).to match(/Cae Code/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/1/)
  end
end
