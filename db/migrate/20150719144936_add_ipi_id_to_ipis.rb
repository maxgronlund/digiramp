class AddIpiIdToIpis < ActiveRecord::Migration
  def change
    add_reference :ipis, :ipi, index: true, foreign_key: false
    add_foreign_key :ipis, :ipis, on_delete: :cascade
  end
end
