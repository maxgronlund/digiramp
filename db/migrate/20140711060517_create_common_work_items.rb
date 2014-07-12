class CreateCommonWorkItems < ActiveRecord::Migration


  def up
    #drop_table :common_work_items
    
    create_table :common_work_items do |t|
      t.belongs_to :account, index: true
      t.belongs_to :common_work, index: true
      t.belongs_to :attachable, polymorphic: true
      t.string     :user_uuid
      t.timestamps
    end
    #add_index :common_work_items, :account_id
    add_index :common_work_items, [:attachable_id, :attachable_type]

  end
  
  def down
    drop_table :common_work_items
  end
    

end
