class AddProToCommonWorks < ActiveRecord::Migration
  def change
    add_column :common_works, :pro, :string
    add_column :common_works, :surveyed_work, :string
    add_column :common_works, :last_distribution, :string
    add_column :common_works, :work_status, :string
    add_column :common_works, :ascap_award_winner, :string
    add_column :common_works, :work_type, :string
    add_column :common_works, :composite_type, :string
    add_column :common_works, :arrangement_of_public_domain_work, :string
    add_column :common_works, :genre, :string
    add_column :common_works, :submitter_work_id, :string
  end
end
