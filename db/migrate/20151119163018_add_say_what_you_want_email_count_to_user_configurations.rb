class AddSayWhatYouWantEmailCountToUserConfigurations < ActiveRecord::Migration
  def change
    add_column :user_configurations, :say_what_you_want_email_count, :integer, default: 0
    UserConfiguration.update_all(say_what_you_want_email_count: 0)
  end
end
