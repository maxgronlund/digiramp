json.array!(@shop_physical_products) do |shop_physical_product|
  json.extract! shop_physical_product, :id, :dimensions, :waight, :shipping_cost, :units_on_stock
  json.url shop_physical_product_url(shop_physical_product, format: :json)
end
