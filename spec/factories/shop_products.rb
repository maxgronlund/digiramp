FactoryGirl.define do
  factory :shop_product, :class => 'Shop::Product' do
    
    title           Faker::Company.name
    body            Faker::Lorem.sentence
    additional_info Faker::Lorem.sentence
    image           { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'products', 'logos', 'logo_image.jpg')) }
    price           (Faker::Commerce.price.to_i * 100) + 100
    user            nil
    account         nil
    download_link   "MyString"
    for_sale        true
    show_in_shop    true
    user_id         1
    account_id      1
    category        'physical-product'
    units_on_stock  50
    
  end

end
