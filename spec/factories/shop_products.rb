FactoryGirl.define do
  factory :shop_product, :class => 'Shop::Product' do
    title "MyString"
body "MyText"
additionl_info "MyText"
image "MyString"
price 1
user nil
account nil
download_link "MyString"
for_sale false
  end

end
