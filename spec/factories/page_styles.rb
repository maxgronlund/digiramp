FactoryGirl.define do
  factory :page_style do
    title           "Deep blue"
    css_tag         "deep_blue"
    backdrop_image  { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'page_styles', 'crowd.jpg')) }
    show_backdrop   true
    bgcolor         "#14131B"
  end

end
