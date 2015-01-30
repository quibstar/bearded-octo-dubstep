class AddAdIdToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :ad_id, :bigint
    add_column :groups, :ad_group_id, :bigint
  end
end
