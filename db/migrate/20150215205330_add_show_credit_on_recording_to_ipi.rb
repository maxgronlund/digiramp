class AddShowCreditOnRecordingToIpi < ActiveRecord::Migration
  def change
    add_column :ipis, :show_credit_on_recordings, :boolean, default: false
    add_column :ipis, :confirmation, :string,            default: "Missing"
  end
end
