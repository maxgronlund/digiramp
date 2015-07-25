class AddOriginalSourceToStakes < ActiveRecord::Migration
  def change
    add_column :stakes, :original_source, :string
  end
end
