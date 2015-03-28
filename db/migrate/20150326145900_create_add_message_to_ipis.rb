class CreateAddMessageToIpis < ActiveRecord::Migration
  def change
    add_column :ipis, :title, :string, default: ''
    add_column :ipis, :message, :text, default: ''
    
  end
end
