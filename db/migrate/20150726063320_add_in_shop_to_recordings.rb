class AddInShopToRecordings < ActiveRecord::Migration
  def change
    #add_column :recordings, :in_shop, :boolean, default: false
    
    Shop::Product.find_each do |product|
      if product.productable_type == 'Recording'
        recording = Recording.find(product.productable_id)
        recording.update(in_shop: true)
      end
    end
    
  end
end
