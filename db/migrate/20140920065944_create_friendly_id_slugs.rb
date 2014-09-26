class CreateFriendlyIdSlugs < ActiveRecord::Migration
  def change
    #create_table :friendly_id_slugs do |t|
    #  t.string   :slug,           :null => false
    #  t.integer  :sluggable_id,   :null => false
    #  t.string   :sluggable_type, :limit => 50
    #  t.string   :scope
    #  t.datetime :created_at
    #end
    #add_index :friendly_id_slugs, :sluggable_id
    #add_index :friendly_id_slugs, [:slug, :sluggable_type]
    #add_index :friendly_id_slugs, [:slug, :sluggable_type, :scope], :unique => true
    #add_index :friendly_id_slugs, :sluggable_type
    
    add_column :users, :slug, :string, unique: true
    add_column :users, :user_name, :string
    
    User.all.each do |user|
      
      if user.name.to_s == ''
        user.name = user.email
        user.save!
      end
      
      if users = User.where(name: user.name).all.count > 1
        users.each_with_index do |usr, index|
          usr.name = user.name + '_' + index.to_s
          usr.save!
        end
      end
      
      

    end
  end
end
