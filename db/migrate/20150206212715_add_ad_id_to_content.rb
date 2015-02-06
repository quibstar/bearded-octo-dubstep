class AddAdIdToContent < ActiveRecord::Migration
  def change
    add_column :copies, :ad_id, :bigint
    remove_column :groups, :ad_id, :bigint
  end
end
