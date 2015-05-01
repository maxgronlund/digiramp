class UpdateUnigCompletenessOnUsers2 < ActiveRecord::Migration
  def change
    User.find_each do |user|
      user.uniq_completeness = user.completeness.to_uniq
      user.save!
    end
  end
end
