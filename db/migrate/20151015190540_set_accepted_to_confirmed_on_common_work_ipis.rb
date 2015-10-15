class SetAcceptedToConfirmedOnCommonWorkIpis < ActiveRecord::Migration
  def change
    CommonWorkIpi.where(status: 1).update_all(status: 2)
  end
end
