class CreateProfessionalInfos < ActiveRecord::Migration
  def change
    create_table :professional_infos do |t|
      t.string :ipi_code
      t.belongs_to :user, index: true, foreign_key: false
      t.timestamps null: false
    end
    
    #add_column :users, :professional_info_id, :integer
    add_foreign_key "professional_infos", "users", on_delete: :cascade
    #
    User.find_each do |user|
      professional_info = ProfessionalInfo.create(user_id: user.id)
    end
  end
end
