class AddIsCardToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :is_card, :boolean, :default => false
  end
end
