class AddIpRefToStakes < ActiveRecord::Migration
  def change
    add_reference :stakes, :ipiable, index: true, polymorphic: true
  end
end
