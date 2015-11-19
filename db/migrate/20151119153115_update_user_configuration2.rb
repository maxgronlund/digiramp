class UpdateUserConfiguration2 < ActiveRecord::Migration
  def change
    configured_users = 0
    UserConfiguration.find_each do |user_configuration|
      user_configuration.save
      if user_configuration.configured
        configured_users += 1
      else
        ap user_configuration
      end
    end
    ap '==================================================='
    ap "configured users : #{configured_users}"
    ap '==================================================='
  end
end
