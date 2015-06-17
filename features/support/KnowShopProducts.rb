module KnowShopProductsHelper

  def find_or_create_shop_product  title
    return @shop_product if @shop_product = shop_product_with_title( title )

    @shop_product       = FactoryGirl.create(:shop_product, title: title, user_id: User.first.id, category: "Physical product")

  end
  
  def shop_product_with_title title
    Shop::Product.find_by(title: title)
  end
  

  

  
end

World(KnowShopProductsHelper)